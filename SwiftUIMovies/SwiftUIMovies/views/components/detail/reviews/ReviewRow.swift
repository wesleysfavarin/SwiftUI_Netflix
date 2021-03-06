//
//  ReviewRow.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct ReviewRow : View {
    let review: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Revisar escrito por \(review.author)").font(.subheadline).fontWeight(.bold)
            Text(review.content).font(.body).lineLimit(0)
            }
            .padding(.top)
            .padding(.bottom)
    }
}

#if DEBUG
struct ReviewRow_Previews : PreviewProvider {
    static var previews: some View {
        ReviewRow(review: Review(id: "0", author: "Teste", content: "Teste body"))
    }
}
#endif
