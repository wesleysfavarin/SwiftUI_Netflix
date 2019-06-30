//
//  CustomListRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct CustomListRow : View {
    @EnvironmentObject var store: Store<AppState>
    
    let list: CustomList
    var coverMovie: Movie? {
        guard let id = list.cover else {
            return nil
        }
        return store.state.moviesState.movies[id]
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            MovieBackdropImage(imageLoader: ImageLoader(poster: coverMovie?.poster_path,
                                                        size: .original),
                               isExpanded: .constant(false),
                               forceBlur: true,
                               fill: true).frame(height: 50)
            VStack(alignment: .leading, spacing: 2) {
                Text(list.name)
                Text("\(list.movies.count) filmes")
                }.blendMode(.overlay)
                .padding()
            }.listRowInsets(EdgeInsets())
            .frame(height: 50)
    }
}

#if DEBUG
struct CustomListRow_Previews : PreviewProvider {
    static var previews: some View {
        CustomListRow(list: CustomList(id: 0, name: "Wow", cover: 0, movies: [0]))
            .environmentObject(sampleStore)
    }
}
#endif
