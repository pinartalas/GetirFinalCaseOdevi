//
//  ProductListPresenter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import Foundation

protocol ProductListPresenterProtocol : AnyObject {
    func viewDidLoad()
    func didSelectProduct(_ productInfo: [String: Any])
    func tappedCartButton()


}


final class ProductListPresenter {
    
    unowned var view: ProductListViewControllerProtocol!
    let router: ProductListRouterProtocol!
    let interactor: ProductListInteractorProtocol!
    
//    private var products: [Product] = []

    
    init(view: ProductListViewControllerProtocol, router: ProductListRouterProtocol, interactor : ProductListInteractorProtocol ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ProductListPresenter : ProductListPresenterProtocol {
    func didSelectProduct(_ productInfo: [String: Any]) {
        router.navigate(.productDetail, productInfo: productInfo)
    }
    
    
    func viewDidLoad() {
        view.setupNavigationBar()
        view.setupCollectionView()
        view.setTitle("Ürünler")
        interactor.fetchSuggestedProducts()
        interactor.fetchProducts()
        
    }
    func tappedCartButton() {
        router.navigate(.card, productInfo: nil)
    }
}

extension ProductListPresenter: ProductListInteractorOutputProtocol {


    func suggestedProductsFetched(_ products: [Product]) {
            view.displaySuggestedProducts(products)
        }
    
    func MainProductsFetched(_ products: [MainProduct]) {
            view.displayMainProducts(products)
        }


        func fetchFailed(with error: Error) {
            view?.displayError(message: error.localizedDescription)
        }
}
