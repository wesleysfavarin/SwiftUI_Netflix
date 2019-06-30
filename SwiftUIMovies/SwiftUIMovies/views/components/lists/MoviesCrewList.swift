//
//  MoviesCrewList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MoviesCrewList : View {
    @EnvironmentObject var store: Store<AppState>
    let crew: Cast
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.withCrew[crew.id] ?? [], displaySearch: false)
            .navigationBarTitle(Text(crew.name))
            .onAppear {
                self.store.dispatch(action: MoviesActions.FetchMovieWithCrew(crew: self.crew.id))
        }
    }
}

#if DEBUG
struct MovieCrewList_Previews : PreviewProvider {
    static var previews: some View {
        MoviesCrewList(crew: sampleCasts.first!)
    }
}
#endif
