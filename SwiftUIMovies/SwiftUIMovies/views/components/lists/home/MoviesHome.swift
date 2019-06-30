//
//  MoviesHome.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MoviesHome : View {
    enum Categories: Int {
        case popular, topRated, upcoming, nowPlaying
    }
    
    @State var selectedIndex: Categories = Categories.popular
    
    var body: some View {
        NavigationView {
            SegmentedControl(selection: $selectedIndex) {
                Text("Populares").tag(Categories.popular)
                Text("Mais votados").tag(Categories.topRated)
                Text("Em breve").tag(Categories.upcoming)
                Text("Lançamentos").tag(Categories.nowPlaying)
                }
                .navigationBarItems(trailing:
                    PresentationButton(destination: SettingsForm()) {
                        Image(systemName: "wrench")
                    }
                )
                .navigationBarHidden(false)
                .padding(.leading)
                .padding(.trailing)
            if selectedIndex == .popular {
                PopularList()
            } else if selectedIndex == .topRated {
                TopRatedList()
            } else if selectedIndex == .upcoming {
                UpcomingList()
            } else if selectedIndex == .nowPlaying {
                NowPlayingList()
            }
        }
    }
}

#if DEBUG
struct MoviesHome_Previews : PreviewProvider {
    static var previews: some View {
        
        MoviesHome()
            .environment(\.colorScheme, .dark)
    }
}
#endif
