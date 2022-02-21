//
//  DetailedViewModel.swift
//  Find'n'Share
//
//  Created by Александр on 20.02.2022.
//
import Foundation

final class DetailedViewModel: DetailedViewModelType {
    var refOnPicture: URL
    var titleOfPicture: String
    
    init(refOnPicture: URL, titleOfPicture: String) {
        self.refOnPicture = refOnPicture
        self.titleOfPicture = titleOfPicture
    }
}
