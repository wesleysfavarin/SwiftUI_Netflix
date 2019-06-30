//
//  UpcomingList.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

final class UpcomingPageListener: PageListener {
    override func loadPage() {
        store.dispatch(action: MoviesActions.FetchUpcoming(page: currentPage))
    }
}


struct UpcomingList : View {
    @EnvironmentObject var store: Store<AppState>
    @State var pageListener = UpcomingPageListener()
    
    var body: some View {
        MoviesList(movies: store.state.moviesState.upcoming, displaySearch: true, pageListener: pageListener)
            .navigationBarTitle(Text("Em breve"))
            .onAppear {
                self.pageListener.loadPage()
        }
    }
}

#if DEBUG
struct LatestList_Previews : PreviewProvider {
    static var previews: some View {
        UpcomingList().environmentObject(sampleStore)
    }
}
#endif
