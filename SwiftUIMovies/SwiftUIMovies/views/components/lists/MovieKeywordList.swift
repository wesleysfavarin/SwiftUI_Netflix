//
//  MovieKeywordList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

final class KeywordPageListener: PageListener {
    var keyword: Int!
    
    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchMovieWithKeywords(keyword: keyword,
                                                                    page: currentPage))
    }
}

struct MovieKeywordList : View {
    @EnvironmentObject var store: Store<AppState>
    @State var pageListener = KeywordPageListener()
    let keyword: Keyword
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.withKeywords[keyword.id] ?? [], displaySearch: false, pageListener: pageListener)
            .navigationBarTitle(Text(keyword.name.capitalized))
            .onAppear {
                self.pageListener.keyword = self.keyword.id
                self.pageListener.loadPage()
        }
    }
}

#if DEBUG
struct MovieKeywordList_Previews : PreviewProvider {
    static var previews: some View {
        MovieKeywordList(keyword: Keyword(id: 0, name: "Teste"))
    }
}
#endif
