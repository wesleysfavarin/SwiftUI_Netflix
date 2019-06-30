//
//  Tabbar.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI

struct Tabbar : View {
    @EnvironmentObject var store: Store<AppState>
    @State var selectedTab = Tab.movies
    
    enum Tab: Int {
        case movies, discover, myLists
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(image)
            Text(text)
        }
    }
    
    var body: some View {
        TabbedView(selection: $selectedTab) {
            MoviesHome().tabItemLabel(tabbarItem(text: "Filmes", image: "icon-movies")).tag(Tab.movies)
            DiscoverView().tabItemLabel(tabbarItem(text: "Procurar", image: "icon-discover")).tag(Tab.discover)
            MyLists().tabItemLabel(tabbarItem(text: "Minha lista", image: "icon-my-lists")).tag(Tab.myLists)
            }
            .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct Tabbar_Previews : PreviewProvider {
    static var previews: some View {
        Tabbar().environmentObject(sampleStore).environment(\.colorScheme, .dark)
    }
}
#endif
