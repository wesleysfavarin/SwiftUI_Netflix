//
//  Movie.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI

struct Movie: Codable, Identifiable {
    let id: Int
    
    let original_title: String
    let title: String
    var userTitle: String {
        return AppUserDefaults.alwaysOriginalTitle ? original_title : title
    }
    
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Float
    let vote_average: Float
    let vote_count: Int
    
    let release_date: String
    var releaseDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        return formatter.date(from: release_date)
    }
    
    let genres: [Genre]?
    let runtime: Int?
    let status: String?
    
    var keywords: Keywords?
    var images: Images?
    
    var production_countries: [productionCountry]?
    
    struct Keywords: Codable {
        let keywords: [Keyword]?
    }
    
    struct Images: Codable {
        let posters: [MovieImage]?
        let backdrops: [MovieImage]?
    }
    
    struct productionCountry: Codable, Identifiable {
        let id = UUID()
        let name: String
    }
}

let sampleMovie = Movie(id: 0,
                        original_title: "Teste filme",
                        title: "Teste filme",
                        overview: "Teste descricao",
                        poster_path: "/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",
                        backdrop_path: "/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",
                        popularity: 50.5,
                        vote_average: 8.9,
                        vote_count: 1000,
                        release_date: "1972-03-14",
                        genres: [Genre(id: 0, name: "teste")],
                        runtime: 80,
                        status: "released")
