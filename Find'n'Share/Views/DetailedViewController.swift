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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = secondaryColor
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    private let largePictureImageView = UIImageView()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.0
        button.setTitle("Поделиться", for: .normal)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = secondaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(presentShareSheet), for: .touchUpInside)
        return button
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
        setupTitleLable()
        setupShareButton()
        titleLabel.text = viewModel.titleOfPicture
    }
    
    private func addingSubviews() {
        view.addSubview(largePictureImageView)
        view.addSubview(titleLabel)
        view.addSubview(shareButton)
    }
    
    private func setupLargePictureImageView() {
        largePictureImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width)
        }
    }
    
    private func setupTitleLable() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(largePictureImageView.snp.top).offset(8)
        }
    }
    
    private func setupShareButton() {
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(largePictureImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }

// MARK: Nuke presets
    
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
    
// MARK: Setup share method

    @objc private func presentShareSheet() {
        let shareSheetVC = UIActivityViewController(
            activityItems: [largePictureImageView.image, viewModel.refOnPicture],
            applicationActivities: nil
        )
        present(shareSheetVC, animated: true)
    }
    
}


