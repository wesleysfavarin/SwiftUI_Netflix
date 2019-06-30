//
//  MovieBackdrop.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieBackdrop: View {
    @EnvironmentObject var store: Store<AppState>
    @State var seeImage = false
    
    let movieId: Int
    var movie: Movie! {
        return store.state.moviesState.movies[movieId]
    }
    
    //MARK: - View computed properties
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            MovieBackdropImage(imageLoader: ImageLoader(poster: movie.backdrop_path ?? movie.poster_path,
                                                        size: .original),
                               isExpanded: $seeImage)
                .tapAction {
                    withAnimation{
                        self.seeImage.toggle()
                    }
            }
            if !seeImage {
                MovieBackdropInfo(movie: movie)
            }
            }.listRowInsets(EdgeInsets())
    }
}


#if DEBUG
struct MovieBackdrop_Previews : PreviewProvider {
    static var previews: some View {
        MovieBackdrop(movieId: sampleMovie.id).environmentObject(sampleStore)
    }
}
#endif
