//
//  MovieImage.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieImage: Codable, Identifiable {
    let id = UUID()
    let aspect_ratio: Float
    let file_path: String
    let height: Int
    let width: Int
}
