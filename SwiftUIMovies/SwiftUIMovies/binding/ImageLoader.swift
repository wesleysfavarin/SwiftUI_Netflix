//
//  ImageLoader.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

final class ImageLoader: BindableObject {
    let didChange = PassthroughSubject<UIImage?, Never>()
    
    let poster: String?
    let size: ImageService.Size
    
    var image: UIImage? = nil {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(self.image)
            }
        }
    }
    
    var missing: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(nil)
            }
        }
    }
    
    init(poster: String?, size: ImageService.Size) {
        self.size = size
        self.poster = poster
    }
    
    func loadImage() {
        guard let poster = poster else {
            missing = true
            return
        }
        ImageService.shared.image(poster: poster, size: .medium) { (result) in
            do { self.image = try result.get() } catch { }
        }
    }
}
