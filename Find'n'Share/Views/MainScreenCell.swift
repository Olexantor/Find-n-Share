//
//  MainScreenCell.swift
//  Find'n'Share
//
//  Created by Александр on 17.02.2022.
//

import Nuke
import UIKit

final class MainScreenCell: UICollectionViewCell {
    static let identifier = "Main screen cell"
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = mainColor
        return view
    }()
    
    weak var viewModel: MainScreenCellViewModelType? {
            didSet {
                guard let viewModel = viewModel else { return }
                getPicture(with: viewModel.urlOfPicture)
            }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPicture(with url: URL) {
        let contentModes = ImageLoadingOptions.ContentModes(
            success: .scaleAspectFit,
            failure: .scaleAspectFit,
            placeholder: .scaleAspectFit
        )
        let options = ImageLoadingOptions(
            placeholder: UIImage(systemName: "timer"),
            transition: .fadeIn(duration: 0.5),
            failureImage: UIImage(systemName: "clear"),
            failureImageTransition: .fadeIn(duration: 0.5),
            contentModes: contentModes)
        
        loadImage(with: url, options: options, into: imageView)
    }

}
