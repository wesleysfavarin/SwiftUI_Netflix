//
//  KeywordBadge.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct KeywordBadge : View {
    let keyword: Keyword
    
    var body: some View {
        NavigationButton(destination: MovieKeywordList(keyword: keyword)) {
            RoundedBadge(text: keyword.name)
        }
    }
}

#if DEBUG
struct KeywordBadge_Previews : PreviewProvider {
    static var previews: some View {
        KeywordBadge(keyword: Keyword(id: 0, name: "Teste"))
    }
}
#endif
