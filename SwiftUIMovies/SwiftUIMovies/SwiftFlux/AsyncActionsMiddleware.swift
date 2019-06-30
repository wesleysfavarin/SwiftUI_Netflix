//
//  AsyncActionsMiddleware.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
public let asyncActionsMiddleware: Middleware<FluxState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? AsyncAction {
                action.execute(state: getState(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}
