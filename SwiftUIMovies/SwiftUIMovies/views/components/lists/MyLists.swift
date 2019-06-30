//
//  MyLists.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MyLists : View {
    @State var selectedList: Int = 0
    @EnvironmentObject var store: Store<AppState>
    
    var customListsSection: some View {
        Section(header: Text("Lista Customizada")) {
            PresentationButton(destination: CustomListForm().environmentObject(store)) {
                Text("Criar lista customizada").color(.steam_blue)
            }
            ForEach(store.state.moviesState.customLists.compactMap{ $0.value} ) { list in
                NavigationButton(destination: CustomListDetail(listId: list.id)) {
                    CustomListRow(list: list)
                }
                }
                .onDelete { (index) in
                    let list = self.store.state.moviesState.customLists.compactMap{ $0.value }[index.first!]
                    self.store.dispatch(action: MoviesActions.RemoveCustomList(list: list.id))
            }
        }
    }
    
    var wishlistSection: some View {
        Section(header: Text("Lisa Desejos")) {
            ForEach(store.state.moviesState.wishlist.map{ $0.id }) {id in
                NavigationButton(destination: MovieDetail(movieId: id)) {
                    MovieRow(movieId: id)
                }
                }
                .onDelete { (index) in
                    let movie = self.store.state.moviesState.wishlist.map{ $0.id }[index.first!]
                    self.store.dispatch(action: MoviesActions.RemoveFromWishlist(movie: movie))
                    
            }
        }
    }
    
    var seenSection: some View {
        Section(header: Text("Visto")) {
            ForEach(store.state.moviesState.seenlist.map{ $0.id }) {id in
                NavigationButton(destination: MovieDetail(movieId: id)) {
                    MovieRow(movieId: id)
                }
                }
                .onDelete { (index) in
                    let movie = self.store.state.moviesState.seenlist.map{ $0.id }[index.first!]
                    self.store.dispatch(action: MoviesActions.RemoveFromSeenList(movie: movie))
            }
        }
    }
    var body: some View {
        NavigationView {
            List {
                customListsSection
                SegmentedControl(selection: $selectedList) {
                    Text("Desejo").tag(0)
                    Text("Visto").tag(1)
                }
                if selectedList == 0 {
                    wishlistSection
                } else if selectedList == 1 {
                    seenSection
                }
                }
                .navigationBarTitle(Text("Minha Lista"))
        }
    }
}

#if DEBUG
struct MyLists_Previews : PreviewProvider {
    static var previews: some View {
        MyLists(selectedList: 0).environmentObject(sampleStore)
    }
}
#endif

