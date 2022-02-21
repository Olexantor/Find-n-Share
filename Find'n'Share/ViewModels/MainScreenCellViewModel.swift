//
//  MainScreenCellViewModel.swift
//  Find'n'Share
//
//  Created by Александр on 20.02.2022.
//
import Foundation

final class MainScreenCellViewModel: MainScreenCellViewModelType {
    var urlOfPicture: URL
    
    init(urlOfPicture: URL) {
        self.urlOfPicture = urlOfPicture
    }
}
