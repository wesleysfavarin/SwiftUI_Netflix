//
//  Review.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI
struct Review: Codable, Identifiable {
    let id: String
    let author: String
    let content: String
}
