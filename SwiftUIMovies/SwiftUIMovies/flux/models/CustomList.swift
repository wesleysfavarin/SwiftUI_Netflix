//
//  CustomList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI
struct CustomList: Codable, Identifiable {
    let id: Int
    var name: String
    var cover: Int?
    var movies: [Int]
}
