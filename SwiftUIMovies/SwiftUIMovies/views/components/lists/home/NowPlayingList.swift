//
//  NowPlayingList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

final class NowPlayingPageListener: PageListener {
    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchNowPlaying(page: currentPage))
    }
}


struct NowPlayingList : View {
    @EnvironmentObject var store: Store<AppState>
    @State var pageListener = NowPlayingPageListener()
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.nowPlaying, displaySearch: true, pageListener: pageListener)
            .navigationBarTitle(Text("Lançamentos"))
            .onAppear {
                self.pageListener.loadPage()
        }
    }
}

#if DEBUG
struct NowPlayingList_Previews : PreviewProvider {
    static var previews: some View {
        NowPlayingList()
    }
}
#endif
