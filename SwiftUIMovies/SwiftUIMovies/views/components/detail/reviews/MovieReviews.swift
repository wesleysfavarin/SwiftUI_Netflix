//
//  MovieReviews.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieReviews : View {
    @EnvironmentObject var store: Store<AppState>
    @Environment(\.isPresented) var isPresented
    
    let movie: Int
    
    var reviews: [Review] {
        return store.state.moviesState.reviews[movie] ?? []
    }
    
    func onCloseButton() {
        isPresented?.value = false
    }
    
    var body: some View {
        NavigationView {
            List(reviews) {review in
                ReviewRow(review: review)
                }
                .navigationBarTitle(Text("Rever"))
                .navigationBarItems(trailing: Button(action: onCloseButton) {
                    Image(systemName: "xmark")
                })
            }.onAppear{
                self.store.dispatch(action: MoviesActions.FetchMovieReviews(movie: self.movie.id))
        }
    }
}
