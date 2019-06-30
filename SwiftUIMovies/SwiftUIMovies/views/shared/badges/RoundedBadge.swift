//
//  RoundedBadge.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct RoundedBadge : View {
    let text: String
    var body: some View {
        HStack {
            Text(text.capitalized)
                .font(.footnote)
                .fontWeight(.bold)
                .color(.white)
                .padding(.leading, 10)
                .padding(.top, 5)
                .padding(.bottom, 5)
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 5, height: 10)
                .foregroundColor(.white)
                .padding(.trailing, 10)
            
            }
            .background(
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(12)
            ).shadow(color: .secondary, radius: 1, x: 0, y: 1)
    }
}

#if DEBUG
struct RoundedBadge_Previews : PreviewProvider {
    static var previews: some View {
        RoundedBadge(text: "Teste")
    }
}
#endif
