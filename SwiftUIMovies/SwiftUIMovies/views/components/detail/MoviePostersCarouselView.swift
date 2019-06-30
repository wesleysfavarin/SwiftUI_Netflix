//
//  MoviePostersCarouselView.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MoviePostersCarouselView : View {
    let posters: [MovieImage]
    @Binding var selectedPoster: MovieImage?
    
    func computeCarouselPosterScale(width: Length, itemX: Length) -> Length {
        let trueX = itemX - (width/2 - 250/3)
        if trueX < -5 {
            return 1 - (abs(trueX) / width)
        }
        if trueX > 5 {
            return 1 - (trueX / width)
        }
        return 1
    }
    
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .center) {
                ScrollView(showsHorizontalIndicator: false) {
                    HStack(spacing: 200) {
                        ForEach(self.posters) { poster in
                            GeometryReader { reader2 in
                                BigMoviePosterImage(imageLoader: ImageLoader(poster: poster.file_path,
                                                                             size: .medium))
                                    .scaleEffect(self.computeCarouselPosterScale(width: reader.frame(in: .global).width,
                                                                                 itemX: reader2.frame(in: .global).midX),
                                                 anchor: .center)
                                    .tapAction {
                                        self.selectedPoster = nil
                                }
                            }
                        }
                    }
                    }
                    .position(x: reader.frame(in: .global).midX,
                              y: reader.frame(in: .global).midY)
                    .tapAction {
                        self.selectedPoster = nil
                }
            }
        }
    }
}

#if DEBUG
struct MoviePostersCarouselView_Previews : PreviewProvider {
    static var previews: some View {
        MoviePostersCarouselView(posters: [MovieImage(aspect_ratio: 0.666666666666667,
                                                      file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                                      height: 720,
                                                      width: 1280),
                                           MovieImage(aspect_ratio: 0.666666666666667,
                                                      file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                                      height: 720,
                                                      width: 1280),
                                           MovieImage(aspect_ratio: 0.666666666666667,
                                                      file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                                      height: 720,
                                                      width: 1280),
                                           MovieImage(aspect_ratio: 0.666666666666667,
                                                      file_path: "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
                                                      height: 720,
                                                      width: 1280)],
                                 selectedPoster: .constant(nil))
    }
}
#endif
