//
//  MoviesState.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

struct MoviesState: FluxState, Codable {
    var movies: [Int: Movie] = [:]
    var recommended: [Int: [Int]] = [:]
    var similar: [Int: [Int ]] = [:]
    var popular: [Int] = []
    var topRated: [Int] = []
    var upcoming: [Int] = []
    var nowPlaying: [Int] = []
    var search: [String: [Int]] = [:]
    var searchKeywords: [String: [Keyword]] = [:]
    
    var discover: [Int] = []
    var discoverFilter: DiscoverFilter?
    
    var wishlist: Set<Int> = Set()
    var seenlist: Set<Int> = Set()
    
    var withGenre: [Int: [Int]] = [:]
    var withKeywords: [Int: [Int]] = [:]
    var withCrew: [Int: [Int]] = [:]
    var reviews: [Int: [Review]] = [:]
    
    var customLists: [Int: CustomList] = [:]
    
    var genres: [Genre] = []
    
    enum CodingKeys: String, CodingKey {
        case movies, wishlist, seenlist, customLists
    }
}
