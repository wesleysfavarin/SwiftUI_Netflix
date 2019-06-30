//
//  MovieAddToListRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieAddToListRow : View {
    @EnvironmentObject var store: Store<AppState>
    
    @State var addedToWishlist: Bool {
        return store.state.moviesState.wishlist.contains(movieId)
    }
    
    @State var addedToSeenlist: Bool {
        return store.state.moviesState.seenlist.contains(movieId)
    }
    
    let movieId: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            BorderedButton(text: addedToWishlist ? "Lista desejo" : "Add lista desejo",
                           systemImageName: "heart",
                           color: .pink,
                           isOn: addedToWishlist,
                           action: {
                            self.store.dispatch(action: MoviesActions.AddToWishlist(movie: self.movieId))
            })
            
            BorderedButton(text: addedToSeenlist ? "Vistos" : "Marca com visto",
                           systemImageName: "eye",
                           color: .green,
                           isOn: addedToSeenlist,
                           action: {
                            self.store.dispatch(action: MoviesActions.AddToSeenList(movie: self.movieId))
            })
            }.padding(.top, 8)
            .padding(.bottom, 8)
    }
}

#if DEBUG
struct MovieAddToList_Previews : PreviewProvider {
    static var previews: some View {
        MovieAddToListRow(addedToWishlist: true,
                          addedToSeenlist: false,
                          movieId: 0).environmentObject(sampleStore)
    }
}
#endif
