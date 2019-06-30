//
//  Cast.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI
struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let department: String?
    let profile_path: String?
}
