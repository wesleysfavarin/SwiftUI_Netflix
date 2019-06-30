//
//  SearchField.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct SearchField : View {
    @Binding var searchText: String
    let placeholder: Text
    let onUpdateSearchText: (String) -> Void
    
    func onKeyStroke() {
        onUpdateSearchText(searchText)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: -10) {
            Image(systemName: "magnifyingglass")
            TextField($searchText,
                      placeholder: Text("Pesquisar algum filme"))
                .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                    .debounce(for: 0.5,
                              scheduler: DispatchQueue.main),
                           perform: onKeyStroke)
                .textFieldStyle(.roundedBorder)
                .listRowInsets(EdgeInsets())
                .padding()
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Text("cancelar").color(.blue)
                }).animation(.basic())
            }
        }
    }
}

#if DEBUG
struct SearchField_Previews : PreviewProvider {
    static var previews: some View {
        SearchField(searchText: .constant("texto pesquisado"),
                    placeholder: Text("Pesquisar alguma coisa"),
                    onUpdateSearchText: {text in
                        
        })
    }
}
#endif
