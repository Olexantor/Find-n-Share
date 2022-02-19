//
//  MainScreenCell.swift
//  Find'n'Share
//
//  Created by Александр on 17.02.2022.
//

import UIKit

final class MainScreenCell: UICollectionViewCell {
    static let identifier = "Main screen cell"
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = mainColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
