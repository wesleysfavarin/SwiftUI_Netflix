//
//  Font.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation
import SwiftUI

extension Font {
    public static func FHACondFrenchNC(size: Length) -> Font {
        return Font.custom("FHA Condensed French NC", size: size)
    }
    
    public static func AmericanCaptain(size: Length) -> Font {
        return Font.custom("American Captain", size: size)
    }
    
    public static func FjallaOne(size: Length) -> Font {
        return Font.custom("FjallaOne-Regular", size: size)
    }
}

struct TitleFont: ViewModifier {
    let size: Length
    func body(content: Content) -> some View {
        return content.font(.FjallaOne(size: size))
    }
}
