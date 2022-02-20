//
//  MainScreenViewModelType.swift
//  Find'n'Share
//
//  Created by Александр on 19.02.2022.
//

import Foundation

protocol MainScreenViewModelType {
    var refsOnPictures: Box<[URL]> { get }
    
    var titlesOfPictures: [String] { get }
    
    func fetchRefsOnPicturesWith(request: String)
    
    func numberOfItems() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelType?
    
    func selectRow(atIndexPath indexPath: IndexPath)
}
