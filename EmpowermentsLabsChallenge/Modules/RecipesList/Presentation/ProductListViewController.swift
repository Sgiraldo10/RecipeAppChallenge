//
//  ProductListViewController.swift
//  ProductList
//
//  Created Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

final class ProductListViewController: BaseViewController<ProductListPresenterType, ProductListViewType> {
    private var collectionViewDataSource: ProductCollectionViewDataSource!

    override func loadView() {
        view = ProductListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func initialSetup() {
        customView.searchProductBar.delegate = self
        customView.productCollectionView.layer.cornerRadius = 10.0

        collectionViewDataSource = ProductCollectionViewDataSource(
            collectionView: customView.productCollectionView,
            sections: [],
            delegate: self)
    }
}

extension ProductListViewController: ProductListViewControllerType {
    func showProduct(_ productSection: ProductListSectionViewModel) {
        collectionViewDataSource.sections = [productSection]
    }

    func showEmptyState(_ productSection: ProductListSectionViewModel, message: String) {
        collectionViewDataSource.sections = [productSection]

        customView.hideSearchView(hide: false, from: view)
        customView.setSearchComponentDescription(message)
    }

    func setDescriptionTitle(_ title: String) {
        customView.setDescriptionTitle(title)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }

        presenter.searchBarSearchButtonClicked(with: query)
        customView.searchProductBar.resignFirstResponder()
        customView.hideBackgroundView(hide: true, from: view)
        customView.hideSearchView(hide: true, from: view)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        customView.searchProductBar.setShowsCancelButton(true, animated: true)
        customView.hideBackgroundView(hide: false, from: customView.searchBackgroundView)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        customView.cancelSearchBar()
        customView.hideBackgroundView(hide: true, from: view)
    }

    func didSelectItem(at indexPath: IndexPath) {
        presenter.selectedItem(at: indexPath)
    }

    func loadMore() {
        presenter.loadMoreReached()
    }
}
