//
//  ProductListContract.swift
//  ProductList
//
//  Created Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

protocol ProductListViewControllerType: CollectionViewDelegate, ErrorShowable, ProgressShowable, UISearchBarDelegate {
    func showProduct(_ productSection: ProductListSectionViewModel)
    func showEmptyState(_ productSection: ProductListSectionViewModel, message: String)
    func setDescriptionTitle(_ title: String)
}

protocol ProductListPresenterType: Bindable {
    func searchBarSearchButtonClicked(with text: String)
    func selectedItem(at indexpath: IndexPath)
    func loadMoreReached()
}

protocol ProductListViewType: UIView {
    var productCollectionView: UICollectionView { get }
    var searchProductBar: UISearchBar { get }
    var searchBackgroundView: UIView { get }

    func setSearchComponentDescription(_ description: String)
    func hideBackgroundView(hide: Bool, from view: UIView)
    func hideSearchView(hide: Bool, from view: UIView)
    func setDescriptionTitle(_ title: String)
    func cancelSearchBar()
}
