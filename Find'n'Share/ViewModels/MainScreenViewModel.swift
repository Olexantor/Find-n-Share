//
//  MainScreenViewModel.swift
//  Find'n'Share
//
//  Created by Александр on 19.02.2022.
//

import Foundation

final class MainScreenViewModel: MainScreenViewModelType {
    var refsOnPictures: Box<[URL]> = Box([])
    var titlesOfPictures = [String]()
    private var selectedIndexPath: IndexPath?
    
    func numberOfItems() -> Int {
        refsOnPictures.value.count
        }
    
    func fetchRefsOnPicturesWith(request: String) {
        NetworkManager.shared.fetchLinksWith(query: request) { result in
            switch result {
            case .success(let picture):
                self.refsOnPictures.value = picture.refsOnPictures
                self.titlesOfPictures = picture.titlesOfPictures
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelType? {
        let url = refsOnPictures.value[indexPath.item]
        return MainScreenCellViewModel(urlOfPicture: url)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func viewModelForSelectedRow() -> DetailedViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailedViewModel(
            refOnPicture: refsOnPictures.value[selectedIndexPath.item],
            titleOfPicture: titlesOfPictures[selectedIndexPath.item]
        )
    }
}
