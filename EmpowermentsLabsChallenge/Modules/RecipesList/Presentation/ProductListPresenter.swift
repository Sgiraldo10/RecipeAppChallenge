//
//  ProductListPresenter.swift
//  ProductList
//
//  Created Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import Foundation

final class ProductListPresenter: BasePresenter<ProductListViewControllerType> {
    struct Dependencies {
        var coordinator: ProductListCoordinatorType
        var searchProductUseCase: BaseUseCase<ProductsResult, SearchProductParams>
    }

    private let dependencies: Dependencies
    private var productResult: ProductsResult?
    private var recipes: [ProductInformation] = []
    private var recipeToSearch: String = ""

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }

    private func searchProduct(by name: String, paginate: CorePaginate? = nil) {
        view.showProgress()
        dependencies.searchProductUseCase.execute(
            params: SearchProductParams(query: name, paging: paginate),
            onSuccess: { productList in
                self.processProductList(productList)
            },
            onError: { error in
                self.view.presentError(error)
                self.view.hideProgress()
            },
            onFinished: {
                self.view.hideProgress()
            })
    }

    private func processProductList(_ productResult: ProductsResult) {
        self.productResult = productResult
        recipes.append(contentsOf: productResult.results)

        if recipes.isEmpty {
            showEmptyView()
        } else {
            showProducts(recipes)
        }
    }

    private func showProducts(_ products: [ProductInformation]) {
        view.showProduct(ProductListSectionViewModel(title: "", data: products))
        view.setDescriptionTitle("Artículos encontrados.")
    }

    private func showEmptyView() {
        view.showEmptyState(ProductListSectionViewModel(title: "", data: []), message: "Producto no encontrado, intente de nuevo.")
    }
}

extension ProductListPresenter: ProductListPresenterType {
    func searchBarSearchButtonClicked(with text: String) {
        recipeToSearch = text
        recipes = []
        searchProduct(by: text)
    }

    func selectedItem(at indexpath: IndexPath) {
        guard indexpath.row < recipes.count else {
            return
        }

        let selectedProduct = recipes[indexpath.row]
        dependencies.coordinator.runProductDetailModule(for: selectedProduct)
    }

    func loadMoreReached() {
        guard let productResult = self.productResult else {
            return
        }

        searchProduct(by: recipeToSearch, paginate: productResult.paginate)
    }
}
