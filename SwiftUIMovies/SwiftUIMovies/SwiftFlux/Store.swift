//
//  Store.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 13.0, *)
final public class Store<State: FluxState>: BindableObject {
    
    public enum Queue {
        case main, background
    }
    
    public let didChange = PassthroughSubject<State, Never>()
    
    private(set) public var state: State {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(self.state)
            }
        }
    }
    
    private let backgroundQueue = DispatchQueue(label: "Flux queue",
                                                qos: DispatchQoS.userInitiated)
    private var dispatchFunction: DispatchFunction!
    private let reducer: Reducer<State>
    private let lock = NSLock()
    private let queueMode: Queue
    
    public init(reducer: @escaping Reducer<State>,
                middleware: [Middleware<State>] = [],
                state: State,
                queue: Queue) {
        self.reducer = reducer
        self.state = state
        self.queueMode = queue
        
        var middleware = middleware
        middleware.append(asyncActionsMiddleware)
        self.dispatchFunction = middleware
            .reversed()
            .reduce(
                { [unowned self] action in
                    self._dispatch(action: action) },
                { dispatchFunction, middleware in
                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                    let getState = { [weak self] in self?.state }
                    return middleware(dispatch, getState)(dispatchFunction)
            })
    }
    
    private func currentQueue() -> DispatchQueue {
        queueMode == .main ? DispatchQueue.main : backgroundQueue
    }
    
    
    public func dispatch(action: Action) {
        dispatchFunction(action)
    }
    
    private func _dispatch(action: Action) {
        currentQueue().async {
            self.lock.lock()
            var state = self.state
            state = self.reducer(state, action)
            self.state = state
            self.lock.unlock()
        }
    }
}
