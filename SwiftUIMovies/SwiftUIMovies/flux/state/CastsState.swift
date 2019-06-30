//
//  CastsState.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

struct CastsState: FluxState {
    var casts: [Int: Cast] = [:]
    var castsMovie: [Int: [Int]] = [:]
}
