//
//  ViewController.swift
//  Find'n'Share
//
//  Created by Александр on 16.02.2022.
//
import Nuke
import SnapKit
import UIKit

final class MainScreenViewController: UIViewController {
    private var viewModel: MainScreenViewModelType?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = secondaryColor
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let transfrom = CGAffineTransform.init(scaleX: 5, y: 5)
        indicator.transform = transfrom
        return indicator
    }()
    
    private let searchController = UISearchController(
    searchResultsController: nil
    )
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 8,
        left: 8,
        bottom: 8,
        right: 8
    )
    private var paddingWidth: CGFloat {
        sectionInsets.left * (itemsPerRow + 1)
    }
    private var availableWidth: CGFloat {
        collectionView.frame.width - paddingWidth
    }
    private var widthOfItem: CGFloat {
        availableWidth / itemsPerRow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenViewModel()
        setupActivityIndicator()
        setupNavigationBar()
        setupSearchController()
        setupCollectionView()
        viewModel?.refsOnPictures.bind { [weak self] (_) in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivityIndicator() {
        navigationController?.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        title = "Find'n'share"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = secondaryColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: UIControl.Event.primaryActionTriggered
        )
    }
    
    @objc private func searchButtonTapped(textField: UITextField) {
        searchBarButtonClicked(searchController.searchBar)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = mainColor
        collectionView.register(
            MainScreenCell.self,
            forCellWithReuseIdentifier: MainScreenCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource methods

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel?.numberOfItems() ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainScreenCell.identifier, for: indexPath
        ) as? MainScreenCell
        guard let collectionViewCell = cell, let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        collectionViewCell.viewModel = cellViewModel
        return collectionViewCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
         return CGSize(width: widthOfItem, height: widthOfItem)
     }
     
    func collectionView(
     _ collectionView: UICollectionView,
     layout collectionViewLayout: UICollectionViewLayout,
     insetForSectionAt section: Int
    ) -> UIEdgeInsets {
         return sectionInsets
     }
     
    func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         minimumLineSpacingForSectionAt section: Int
     ) -> CGFloat {
         return sectionInsets.left
     }
     
     func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         minimumInteritemSpacingForSectionAt section: Int
     ) -> CGFloat {
         return sectionInsets.left
     }
}

// MARK: - UICollectionViewDelegate methods

extension MainScreenViewController: UICollectionViewDelegate {
    
}

// MARK: SearchBarDelegate

extension MainScreenViewController: UISearchBarDelegate {
    private func searchBarButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        guard let textField = searchBar.text, !textField.isEmpty, let viewModel = viewModel else { return }
        viewModel.fetchRefsOnPicturesWith(request: textField)
    }
}
