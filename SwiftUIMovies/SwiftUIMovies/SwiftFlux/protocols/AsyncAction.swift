//
//  AsyncAction.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
public protocol AsyncAction: Action {
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction)
}
