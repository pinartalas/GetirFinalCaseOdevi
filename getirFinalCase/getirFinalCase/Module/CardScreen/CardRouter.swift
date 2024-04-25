//
//  CardRouter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

enum CardRoutes {
    case home
}

protocol CardRouterProtocol : AnyObject {
    func navigate(_ route : CardRoutes)
}

final class CardRouter {
    weak var viewController : CardViewController?
    
    static func createModule() -> CardViewController {
        
        let view = CardViewController()
        let interactor = CardInteractor()
        let router = CardRouter()
        
        let presenter = CardPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}


extension CardRouter : CardRouterProtocol {
    func navigate(_ route: CardRoutes) {
        switch route {
        case .home:
            viewController?.navigationController?.popViewController(animated: true)
            
        }
    }
}
