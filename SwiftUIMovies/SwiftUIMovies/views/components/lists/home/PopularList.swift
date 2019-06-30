//
//  PopularList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI
import Combine

final class PopularPageListener: PageListener {
    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchPopular(page: currentPage))
    }
}

struct PopularList : View {
    @EnvironmentObject var store: Store<AppState>
    @State var pageListener = PopularPageListener()
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.popular, displaySearch: true, pageListener: pageListener)
            .navigationBarTitle(Text("Populares"))
            .onAppear {
                self.pageListener.loadPage()
        }
    }
}

#if DEBUG
struct PopularList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularList().environmentObject(sampleStore).environment(\.colorScheme, .dark)
        }
    }
}
#endif
