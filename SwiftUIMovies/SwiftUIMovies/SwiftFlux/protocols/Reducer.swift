//
//  Reducer.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
public typealias Reducer<FluxState> =
    (_ state: FluxState, _ action: Action) -> FluxState

