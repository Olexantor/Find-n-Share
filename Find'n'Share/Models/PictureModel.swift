//
//  PictureModel.swift
//  Find'n'Share
//
//  Created by Александр on 16.02.2022.
//

import Foundation

struct PictureModel: Decodable {
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

struct ImagesResult: Decodable {
    let title: String
    let original: String
}
