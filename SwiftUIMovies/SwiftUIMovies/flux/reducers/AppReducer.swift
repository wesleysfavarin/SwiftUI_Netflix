//
//  AppReducer.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    state.moviesState = moviesStateReducer(state: state.moviesState, action: action)
    state.castsState = castsStateReducer(state: state.castsState, action: action)
    return state
}
