//
//  MovieKeywords.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct MovieKeywords : View {
    let keywords: [Keyword]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Palavras-chave")
                .font(.FjallaOne(size: 20))
                .padding(.leading)
            ScrollView(showsHorizontalIndicator: false) {
                HStack {
                    ForEach(keywords) {keyword in
                        KeywordBadge(keyword: keyword)
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
struct MovieKeywords_Previews : PreviewProvider {
    static var previews: some View {
        MovieKeywords(keywords: [Keyword(id: 0, name: "Teste")])
    }
}
#endif
