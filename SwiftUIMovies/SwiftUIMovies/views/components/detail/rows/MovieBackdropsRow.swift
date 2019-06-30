//
//  MovieBackdropsRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieBackdropsRow : View {
    let backdrops: [MovieImage]
    @Binding var selectedBackdrop: MovieImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Imagens")
                .font(.FjallaOne(size: 20))
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(showsHorizontalIndicator: false) {
                HStack(spacing: 16) {
                    ForEach(self.backdrops) { backdrop in
                        MovieBackdropImage(imageLoader: ImageLoader(poster: backdrop.file_path,
                                                                    size: .original),
                                           isExpanded: .constant(true))
                            .frame(height: 200)
                            .tapAction {
                                withAnimation {
                                    self.selectedBackdrop = backdrop
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
struct MovieBackdropsRow_Previews : PreviewProvider {
    static var previews: some View {
        MovieBackdropsRow(backdrops: [MovieImage(aspect_ratio: 1.7,
                                                 file_path: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
                                                 height: 1200,
                                                 width: 1800)],
                          selectedBackdrop: .constant(nil))
    }
}
#endif
