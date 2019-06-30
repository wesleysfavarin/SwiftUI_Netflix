//
//  MovieOverview.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieOverview : View {
    let movie: Movie
    @State var isOverviewExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Visão geral:").font(.FjallaOne(size: 20))
            Text(movie.overview)
                .font(.subheadline)
                .color(.secondary)
                .lineLimit(self.isOverviewExpanded ? nil : 4)
                .tapAction {
                    withAnimation {
                        self.isOverviewExpanded.toggle()
                    }
            }
            Button(action: {
                withAnimation {
                    self.isOverviewExpanded.toggle()
                }
            }, label: {
                Text(self.isOverviewExpanded ? "Menos" : "Saber mais")
                    .color(.steam_blue)
            })
        }
    }
}

#if DEBUG
struct MovieOverview_Previews : PreviewProvider {
    static var previews: some View {
        MovieOverview(movie: sampleMovie)
    }
}
#endif
