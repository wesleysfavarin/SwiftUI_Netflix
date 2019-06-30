//
//  CastResponse.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

struct CastResponse: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Cast]
}

let sampleCasts = [Cast(id: 0, name: "Cast 1", character: "Character 1", department: nil, profile_path: nil),
                   Cast(id: 1, name: "Cast 2", character: nil, department: "Director 1", profile_path: nil)]
