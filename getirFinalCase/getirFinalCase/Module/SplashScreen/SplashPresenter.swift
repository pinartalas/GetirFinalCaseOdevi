//
//  SplashPresenter.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation


protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    unowned var view: SplashViewProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewProtocol,
         router: SplashRouterProtocol,
         interactor: SplashInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let self else { return }
                self.router.navigate(.homeScreen)
            }
        } else {
            view.noInternerConnection()
        }
    }
    
}

