//
//  ProductDetailRouter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

enum ProductDetailRoutes {
    case cart
    case productList
}

protocol ProductDetailRouterProtocol: AnyObject{
    func navigate(_ route: ProductDetailRoutes)
}

final class ProductDetailRouter {
    
    weak var viewController: ProductDetailView?
    
    static func createModule(productInfo: [String: Any]? = nil) -> ProductDetailView {
        
        let view = ProductDetailView()
        let router = ProductDetailRouter()
        let interactor = ProductDetailInteractor()
        
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor)
        
        presenter.didLoadProductInfo(productInfo)

        
        view.presenter = presenter
        router.viewController = view
        interactor.output = presenter
        
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterProtocol {
    
    func navigate(_ route: ProductDetailRoutes) {
        switch route {
        case .productList :
            viewController?.navigationController?.popViewController(animated: true)
        case .cart :
            print("Cart ekrani olusturulucaktir")
        }
        
        
    }
}
