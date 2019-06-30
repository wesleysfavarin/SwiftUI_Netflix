//
//  MovieDetail.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieDetail : View {
    @EnvironmentObject var store: Store<AppState>
    @State var addSheetShown = false
    @State var showSavedBadge = false
    @State var selectedPoster: MovieImage?
    
    let movieId: Int
    
    //MARK: - App State computed properties
    
    var movie: Movie! {
        return store.state.moviesState.movies[movieId]!
    }
    
    var characters: [Cast]? {
        get {
            guard let ids = store.state.castsState.castsMovie[movie.id] else {
                return nil
            }
            let cast = store.state.castsState.casts.filter{ $0.value.character != nil }
            return ids.filter{ cast[$0] != nil }.map{ cast[$0]! }
        }
    }
    
    var credits: [Cast]? {
        get {
            guard let ids = store.state.castsState.castsMovie[movie.id] else {
                return nil
            }
            let cast = store.state.castsState.casts.filter{ $0.value.department != nil }
            return ids.filter{ cast[$0] != nil }.map{ cast[$0]! }
        }
    }
    
    var recommended: [Movie]? {
        get {
            guard let ids = store.state.moviesState.recommended[movie.id] else {
                return nil
            }
            let movies = store.state.moviesState.movies
            return ids.filter{ movies[$0] != nil }.map{ movies[$0]! }
        }
    }
    
    var similar: [Movie]? {
        get {
            guard let ids = store.state.moviesState.similar[movie.id] else {
                return nil
            }
            let movies = store.state.moviesState.movies
            return ids.filter{ movies[$0] != nil }.map{ movies[$0]! }
        }
    }
    
    // MARK: - Actions
    func fetchMovieDetails() {
        store.dispatch(action: MoviesActions.FetchDetail(movie: movie.id))
        store.dispatch(action: CastsActions.FetchMovieCasts(movie: movie.id))
        store.dispatch(action: MoviesActions.FetchRecommended(movie: movie.id))
        store.dispatch(action: MoviesActions.FetchSimilar(movie: movie.id))
    }
    
    var addActionSheet: ActionSheet {
        get {
            var buttons: [Alert.Button] = []
            let wishlistButton: Alert.Button = .default(Text("Add lista desejos")) {
                self.addSheetShown = false
                self.displaySavedBadge()
                self.store.dispatch(action: MoviesActions.AddToWishlist(movie: self.movieId))
            }
            let seenButton: Alert.Button = .default(Text("Add lista vistos")) {
                self.addSheetShown = false
                self.displaySavedBadge()
                self.store.dispatch(action: MoviesActions.AddToSeenList(movie: self.movieId))
            }
            buttons.append(wishlistButton)
            buttons.append(seenButton)
            for list in store.state.moviesState.customLists.compactMap({ $0.value }) {
                let button: Alert.Button = .default(Text("Add  \(list.name)")) {
                    self.addSheetShown = false
                    self.displaySavedBadge()
                    self.store.dispatch(action: MoviesActions.AddMovieToCustomList(list: list.id,
                                                                                   movie: self.movieId))
                }
                buttons.append(button)
            }
            let cancelButton = Alert.Button.cancel {
                self.addSheetShown = false
            }
            buttons.append(cancelButton)
            let sheet = ActionSheet(title: Text("Add "),
                                    message: Text("Add filme na sua lista"),
                                    buttons: buttons)
            return sheet
        }
    }
    
    func displaySavedBadge() {
        showSavedBadge = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showSavedBadge = false
        }
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                MovieBackdrop(movieId: movie.id)
                MovieRatingRow(movie: movie)
                MovieAddToListRow(addedToWishlist: false,
                                  addedToSeenlist: false,
                                  movieId: movie.id)
                MovieOverview(movie: movie)
                Group {
                    if movie.keywords?.keywords != nil && movie.keywords?.keywords?.isEmpty == false {
                        MovieKeywords(keywords: movie.keywords!.keywords!).frame(height: 100)
                    }
                    if characters != nil && characters?.isEmpty == false {
                        MovieCrosslinePeopleRow(title: "Personagens",
                                                casts: characters ?? []).frame(height: 210)
                    }
                    if credits != nil && credits?.isEmpty == false {
                        MovieCrosslinePeopleRow(title: "Equipe",
                                                casts: credits ?? []).frame(height: 210)
                    }
                    if similar != nil && similar?.isEmpty == false {
                        MovieCrosslineRow(title: "Similares", movies: similar ?? []).frame(height: 270)
                    }
                    if recommended != nil && recommended?.isEmpty == false {
                        MovieCrosslineRow(title: "Recomendados", movies: recommended ?? []).frame(height: 270)
                    }
                    if movie.images?.posters != nil && movie.images?.posters?.isEmpty == false {
                        MoviePostersRow(posters: movie.images!.posters!,
                                        selectedPoster: $selectedPoster)
                            .frame(height: 230)
                    }
                    if movie.images?.backdrops != nil && movie.images?.backdrops?.isEmpty == false {
                        MovieBackdropsRow(backdrops: movie.images!.backdrops!,
                                          selectedBackdrop: $selectedPoster)
                            .frame(height: 310)
                    }
                }
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarItems(trailing: Button(action: onAddButton) {
                    Image(systemName: "text.badge.plus")
                })
                .onAppear {
                    self.fetchMovieDetails()
                }
                .presentation(self.addSheetShown ? addActionSheet : nil)
                .blur(radius: selectedPoster != nil ? 50 : 0)
            
            NotificationBadge(text: "Adicionado com sucesso", color: .blue, show: $showSavedBadge)
                .padding(.bottom, 10)
            if selectedPoster != nil && movie.images?.posters != nil {
                MoviePostersCarouselView(posters: movie.images!.posters!, selectedPoster: $selectedPoster)
            }
        }
    }
    
    func onAddButton() {
        addSheetShown.toggle()
    }
    
}

// MARK: - Preview
#if DEBUG
struct MovieDetail_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetail(movieId: sampleMovie.id).environmentObject(sampleStore)
        }
    }
}
#endif

