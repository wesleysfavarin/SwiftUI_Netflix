//
//  MoviePostersRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MoviePostersRow : View {
    let posters: [MovieImage]
    @Binding var selectedPoster: MovieImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Outros cartazes")
                .font(.FjallaOne(size: 20))
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(showsHorizontalIndicator: false) {
                HStack(spacing: 16) {
                    ForEach(self.posters) { poster in
                        MoviePosterImage(imageLoader: ImageLoader(poster: poster.file_path,
                                                                  size: .small)).tapAction {
                                                                    withAnimation {
                                                                        self.selectedPoster = poster
                                                                    }
                        }
                    }
                    }.padding(.leading)
            }
            }
            .listRowInsets(EdgeInsets())
            .padding(.top)
            .padding(.bottom)
    }
}

#if DEBUG
struct MoviePostersRow_Previews : PreviewProvider {
    static var previews: some View {
        MoviePostersRow(posters: [MovieImage(aspect_ratio: 0.666666666666667,
                                             file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                             height: 720,
                                             width: 1280)],
                        selectedPoster: .constant(nil))
    }
}
#endif

