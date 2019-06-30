//
//  BorderedButton.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct BorderedButton : View {
    let text: String
    let systemImageName: String
    let color: Color
    let isOn: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: systemImageName).foregroundColor(isOn ? .white : color)
                Text(text).color(isOn ? .white : color)
            }
        })
            .padding(6)
            .border(color, width: isOn ? 0 : 1, cornerRadius: 8)
            .background(isOn ? color : Color.clear)
            .cornerRadius(8)
    }
}

#if DEBUG
struct BorderedButton_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            BorderedButton(text: "Add p/ lista desejo",
                           systemImageName: "film",
                           color: .green,
                           isOn: false,
                           action: {
                            
            })
            BorderedButton(text: "Add p/ lista desejo",
                           systemImageName: "film",
                           color: .blue,
                           isOn: true,
                           action: {
                            
            })
        }
    }
}
#endif
