//
//  DetailedViewController.swift
//  Find'n'Share
//
//  Created by Александр on 20.02.2022.
//

import Foundation
import Nuke
import SnapKit
import UIKit

final class DetailedViewController: UIViewController {
    let viewModel: DetailedViewModelType
    private var largePictureImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: DetailedViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = mainColor
        addingSubviews()
        setupLargePictureImageView()
        getPicture(with: viewModel.refOnPicture)
    }
    
    private func addingSubviews() {
        view.addSubview(largePictureImageView)
    }
    
    private func setupLargePictureImageView() {
        largePictureImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width)
        }
    }
    
    private func getPicture(with url: URL) {
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
        
        loadImage(with: url, options: options, into: largePictureImageView)
    }
}
