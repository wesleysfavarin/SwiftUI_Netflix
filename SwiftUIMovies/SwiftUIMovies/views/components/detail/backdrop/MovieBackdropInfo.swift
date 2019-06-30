//
//  MovieBackdropInfo.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieBackdropInfo : View {
    let movie: Movie
    
    var transition: AnyTransition {
        return AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
    }
    
    var animation: Animation {
        Animation.spring(initialVelocity: 2)
            .speed(2)
            .delay(0.5)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(movie.userTitle)
                    .font(.FjallaOne(size: 28))
                    .color(.steam_gold)
                    .lineLimit(nil)
                    .padding(.leading)
                HStack {
                    Text(movie.release_date.prefix(4))
                        .font(.subheadline)
                        .color(.white)
                    if movie.runtime != nil {
                        Text("• \(movie.runtime!) minutos")
                            .font(.subheadline)
                            .color(.white)
                            .transition(transition)
                            .animation(animation)
                    }
                    if movie.status != nil {
                        Text("• \(movie.status!)")
                            .font(.subheadline)
                            .color(.white)
                            .transition(transition)
                            .animation(animation)
                    }
                    }.padding(.leading)
                if movie.production_countries?.isEmpty == false {
                    Text("\(movie.production_countries!.first!.name)")
                        .font(.subheadline)
                        .color(.white)
                        .padding(.leading)
                        .padding(.bottom, 4)
                }
                ScrollView(showsHorizontalIndicator: false) {
                    HStack {
                        ForEach(movie.genres ?? []) { genre in
                            GenreBadge(genre: genre)
                        }
                        }.padding(.leading)
                    }.frame(height: 30)
            }
            }
            .listRowInsets(EdgeInsets())
            .padding(.bottom)
    }
}

#if DEBUG
struct MovieBackdropInfo_Previews : PreviewProvider {
    static var previews: some View {
        MovieBackdropInfo(movie: sampleMovie).environmentObject(sampleStore)
    }
}
#endif
