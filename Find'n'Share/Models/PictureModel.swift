//
//  PictureModel.swift
//  Find'n'Share
//
//  Created by Александр on 16.02.2022.
//
struct PictureModel: Decodable {
    let imagesResults: [ImagesResult]
    
    private enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

struct ImagesResult: Decodable {
    let title: String
    let original: String
}
