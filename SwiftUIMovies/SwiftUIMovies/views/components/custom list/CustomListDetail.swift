//
//  CustomListDetail.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct CustomListDetail : View {
    @EnvironmentObject var store: Store<AppState>
    let listId: Int
    
    var list: CustomList {
        return store.state.moviesState.customLists[listId]!
    }
    
    var body: some View {
        MoviesList(movies: list.movies,
                   displaySearch: false)
            .navigationBarTitle(Text(list.name))
    }
}

#if DEBUG
struct CustomListDetail_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomListDetail(listId: sampleStore.state.moviesState.customLists.first!.key)
                .environmentObject(sampleStore)
        }
    }
}
#endif
