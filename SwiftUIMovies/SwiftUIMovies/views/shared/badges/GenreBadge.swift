//
//  GenreBadge.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct GenreBadge : View {
    let genre: Genre
    
    var body: some View {
        NavigationButton(destination: MoviesGenreList(genre: genre)) {
            RoundedBadge(text: genre.name)
        }
    }
}

#if DEBUG
struct TextBadge_Previews : PreviewProvider {
    static var previews: some View {
        GenreBadge(genre: Genre(id: 0, name: "Teste"))
    }
}
#endif
