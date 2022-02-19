//
//  MainScreenViewModel.swift
//  Find'n'Share
//
//  Created by Александр on 19.02.2022.
//

import Foundation

final class MainScreenViewModel: MainScreenViewModelType {
    var refsOnPictures: Box<[URL]> = Box([])
    
    var searchQuery: String? {
        didSet {
            fetchRefsOnPicturesWith(request: searchQuery ?? "")
        }
    }
    
    func numberOfItems() -> Int {
        refsOnPictures.value.count
        }
    
    func fetchRefsOnPicturesWith(request: String) {
        NetworkManager.shared.fetchLinksWith(query: request) { result in
            switch result {
                
            case .success(let urls):
                self.refsOnPictures.value = urls
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        
    }
}