//
//  CardInteractor.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

protocol CardInteractorProtocol {

}

protocol CardInteractorOutputProtocol: AnyObject {
    
}

final class CardInteractor {
    var output : CardInteractorOutputProtocol?
}

extension CardInteractor : CardInteractorProtocol {

    
    
}
