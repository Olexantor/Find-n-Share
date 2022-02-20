//
//  Picture.swift
//  Find'n'Share
//
//  Created by Александр on 20.02.2022.
//

import Foundation

struct Picture {
    var refsOnPictures = [URL]()
    var titlesOfPictures = [String]()
    
    init?(data: PictureModel) {
        data.imagesResults.forEach { image in
            guard let url = URL(string: image.original) else { return }
            refsOnPictures.append(url)
            titlesOfPictures.append(image.title)
        }
    }
}
