//
//  CustomListForm.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct CustomListForm : View {
    @EnvironmentObject var store: Store<AppState>
    
    @State var listName: String = ""
    @State var movieSearch: String = ""
    @State var listMovieCover: Int?
    
    var body: some View {
        NavigationView {
            Form {
                TopSection(listMovieCover: $listMovieCover, movieSearch: $movieSearch, listName: $listName)
                MovieSearchSection(movieSearch: $movieSearch, listMovieCover: $listMovieCover)
                SaveCancelSection(listName: $listName, listMovieCover: $listMovieCover)
                }
                .navigationBarTitle(Text("Nova lista"))
        }
    }
}

struct TopSection: View {
    @EnvironmentObject var store: Store<AppState>
    
    @Binding var listMovieCover: Int?
    @Binding var movieSearch: String
    @Binding var listName: String
    
    var body: some View {
        Section(header: Text("Lista informação"),
                content: {
                    HStack {
                        Text("Nome:")
                        TextField($listName, placeholder: Text("Nome da sua lista"))
                    }
                    if listMovieCover == nil {
                        SearchField(searchText: $movieSearch,
                                    placeholder: Text("Procurar e add um filme como capa"),
                                    onUpdateSearchText: {text in
                                        if !text.isEmpty {
                                            self.store.dispatch(action: MoviesActions.FetchSearch(query: text, page: 1))
                                        }
                        }).disabled(listMovieCover != nil)
                    }
                    if listMovieCover != nil {
                        MovieRow(movieId: listMovieCover!)
                        Button(action: {
                            self.listMovieCover = nil
                        }, label: {
                            Text("Remover capa").color(.red)
                        })
                    }
        })
    }
}

struct MovieSearchSection: View {
    @EnvironmentObject var store: Store<AppState>
    
    @Binding var movieSearch: String
    @Binding var listMovieCover: Int?
    
    var searchedMovies: [Int] {
        return store.state.moviesState.search[movieSearch]?.prefix(2).map{ $0 } ?? []
    }
    
    var body: some View {
        Section() {
            ForEach(searchedMovies) { movieId in
                MovieRow(movieId: movieId).tapAction {
                    self.listMovieCover = movieId
                    self.movieSearch = ""
                }
            }
        }
    }
}

struct SaveCancelSection: View {
    @EnvironmentObject var store: Store<AppState>
    @Environment(\.isPresented) var isPresented
    
    @Binding var listName: String
    @Binding var listMovieCover: Int?
    
    var body: some View {
        Section {
            Button(action: {
                let newList = CustomList(id: Int.random(in: self.store.state.moviesState.customLists.count ..< 1000^3),
                                         name: self.listName,
                                         cover: self.listMovieCover,
                                         movies: [])
                self.store.dispatch(action: MoviesActions.AddCustomList(list: newList))
                self.isPresented?.value = false
                
            }, label: {
                Text("Criar").color(.blue)
            })
            Button(action: {
                self.isPresented?.value = false
            }, label: {
                Text("Cancelar").color(.red)
            })
        }
    }
}

#if DEBUG
struct CustomListForm_Previews : PreviewProvider {
    static var previews: some View {
        CustomListForm().environmentObject(sampleStore)
    }
}
#endif
