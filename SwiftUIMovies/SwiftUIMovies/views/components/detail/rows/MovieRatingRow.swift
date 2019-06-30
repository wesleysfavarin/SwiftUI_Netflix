//
//  MovieRatingRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieRatingRow : View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                PopularityBadge(score: Int(movie.vote_average * 10))
                Text("\(movie.vote_count) classificações")
                PresentationButton(destination: MovieReviews(movie: movie.id).environmentObject(store),
                                   label: {
                                    HStack {
                                        Text("Rever").color(.steam_blue)
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 5, height: 10)
                                            .foregroundColor(.steam_blue)
                                    }
                })
            }
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
    }
}

#if DEBUG
struct MovieRating_Previews : PreviewProvider {
    static var previews: some View {
        MovieRatingRow(movie: sampleMovie)
    }
}
#endif
