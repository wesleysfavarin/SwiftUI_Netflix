//
//  MoviesGenreList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MoviesGenreList : View {
    @EnvironmentObject var store: Store<AppState>
    let genre: Genre
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.withGenre[genre.id] ?? [], displaySearch: false)
            .navigationBarTitle(Text(genre.name))
            .onAppear {
                self.store.dispatch(action: MoviesActions.FetchMoviesGenre(genre: self.genre))
        }
    }
}

#if DEBUG
struct MoviesGenreList_Previews : PreviewProvider {
    static var previews: some View {
        MoviesGenreList(genre: Genre(id: 0, name: "teste")).environmentObject(store)
    }
}
#endif
