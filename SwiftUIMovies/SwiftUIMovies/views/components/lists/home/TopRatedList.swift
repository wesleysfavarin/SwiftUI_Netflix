//
//  TopRatedList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

final class TopRatedListPageListener: PageListener {
    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchTopRated(page: currentPage))
    }
}

struct TopRatedList : View {
    @EnvironmentObject var store: Store<AppState>
    @State var pageListener = TopRatedListPageListener()
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.topRated, displaySearch: true, pageListener: pageListener)
            .navigationBarTitle(Text("Mais votados"))
            .onAppear {
                self.pageListener.loadPage()
        }
    }
}

#if DEBUG
struct TopRatedList_Previews : PreviewProvider {
    static var previews: some View {
        TopRatedList().environmentObject(sampleStore)
    }
}
#endif
