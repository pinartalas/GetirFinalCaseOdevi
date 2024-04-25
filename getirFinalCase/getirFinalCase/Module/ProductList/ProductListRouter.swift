//
//  ProductListRouter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import Foundation
import UIKit

enum HomeRoutes {
    case productDetail
    case card
}

protocol ProductListRouterProtocol : AnyObject {
    func navigate(_ route: HomeRoutes, productInfo: [String: Any]?)
}

final class ProductListRouter {
    
    weak var viewController: ProductListViewController?
    


    static func createModule() -> ProductListViewController {
        
        let view = ProductListViewController()
        let interactor = ProductListInteractor()
        let router = ProductListRouter()
        let presenter = ProductListPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
                
        return view
    }
}

extension ProductListRouter : ProductListRouterProtocol {
    
    func navigate(_ route: HomeRoutes, productInfo: [String: Any]? = nil) {
        switch route{
        case .productDetail:
                        guard let viewController = viewController else {
                            print("Error: viewController is nil")
                            return
                        }
            let productDetailVC = ProductDetailRouter.createModule(productInfo: productInfo)
                        viewController.navigationController?.pushViewController(productDetailVC, animated: true)
            
        case .card:
            guard let viewController = viewController else{
                print("Error: viewController is nil")
                return
            }
            let card = CardRouter.createModule()
            viewController.navigationController?.pushViewController(card, animated: true)
        }
    }
    
    
}
