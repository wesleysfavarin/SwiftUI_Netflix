//
//  MovieCrosslineRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieCrosslineRow : View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.FjallaOne(size: 20))
                .padding(.leading)
            ScrollView(showsHorizontalIndicator: false) {
                HStack(spacing: 32) {
                    ForEach(self.movies) { movie in
                        MovieDetailRowItem(movie: movie)
                    }
                    }.padding(.leading)
            }
            }
            .listRowInsets(EdgeInsets())
            .padding(.top)
            .padding(.bottom)
    }
}

struct MovieDetailRowItem: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationButton(destination: MovieDetail(movieId: movie.id)) {
                MoviePosterImage(imageLoader: ImageLoader(poster: movie.poster_path, size: .medium))
                Text(movie.userTitle)
                    .font(.body)
                    .color(.primary)
                Text(movie.release_date.prefix(4))
                    .font(.subheadline)
                    .color(.secondary)
            }
            }.frame(width: 120)
    }
}

#if DEBUG
struct MovieDetailRow_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieCrosslineRow(title: "Simples", movies: [sampleMovie, sampleMovie])
        }
    }
}
#endif
