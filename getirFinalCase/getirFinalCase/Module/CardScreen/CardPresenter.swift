//
//  CardPresenter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

protocol CardPresenterProtocol : AnyObject {
    func viewDidLoad()
}
final class CardPresenter {
    
    unowned var view : CardViewControllerProtocol!
    let router : CardRouterProtocol!
    let interactor: CardInteractorProtocol!
    
    init(view: CardViewControllerProtocol!, router: CardRouterProtocol!, interactor: CardInteractorProtocol!) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension CardPresenter : CardPresenterProtocol {
    func viewDidLoad() {
        view.setTitle("Sepet")
        view.setUpViews()
    }
}

extension CardPresenter : CardInteractorOutputProtocol {
    
}
