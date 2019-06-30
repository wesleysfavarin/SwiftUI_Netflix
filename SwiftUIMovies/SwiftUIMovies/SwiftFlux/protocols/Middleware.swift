//
//  Middleware.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
public typealias DispatchFunction = (Action) -> Void
public typealias Middleware<State> = (@escaping DispatchFunction, @escaping () -> FluxState?)
    -> (@escaping DispatchFunction) -> DispatchFunction
