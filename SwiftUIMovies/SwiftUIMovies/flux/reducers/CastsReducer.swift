//
//  CastsReducer.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI
func castsStateReducer(state: CastsState, action: Action) -> CastsState {
    var state = state
    if let action = action as? CastsActions.SetMovieCasts {
        for cast in action.response.cast {
            state.casts[cast.id] = cast
        }
        for cast in action.response.crew {
            state.casts[cast.id] = cast
        }
        state.castsMovie[action.movie] = action.response.cast.map{ $0.id } + action.response.crew.map{ $0.id }
    }
    return state
}
