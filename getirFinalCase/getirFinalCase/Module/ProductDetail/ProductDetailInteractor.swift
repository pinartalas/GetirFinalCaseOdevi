//
//  ProductDetailInteractor.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    
}
protocol ProductDetailInteractorOutputProtocol: AnyObject {
    
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutputProtocol?
}

extension ProductDetailInteractor :ProductDetailInteractorProtocol{
    
}
