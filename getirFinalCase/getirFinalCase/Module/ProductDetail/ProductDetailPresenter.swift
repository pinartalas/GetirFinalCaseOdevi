//
//  ProductDetailPresenter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func tappedLeftArrow()
    func didLoadProductInfo(_ productInfo: [String: Any]!)
}

final class ProductDetailPresenter {
    unowned var view : ProductDetailViewProtocol!
    let router: ProductDetailRouterProtocol!
    let interactor: ProductDetailInteractorProtocol!
    
    init(view: ProductDetailViewProtocol, router: ProductDetailRouterProtocol, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ProductDetailPresenter : ProductDetailPresenterProtocol {

    
    func viewDidLoad() {
        view.setUpUI()
        view.setTitle("Ürün Detayı")
        view.setUpNavBar()
        view.addToCartButtonTapped()
        
    }
    func tappedLeftArrow() {
        router.navigate(.productList)
    }
    func didLoadProductInfo(_ productInfo: [String: Any]!) {
        // productInfo'dan ürün adını al
        view.setProductInfo(productInfo)
        
    }
}

extension ProductDetailPresenter : ProductDetailInteractorOutputProtocol {
    
}
