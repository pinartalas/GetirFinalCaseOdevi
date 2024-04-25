//
//  ProductListEntity.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import Foundation


import Foundation

// MARK: - Welcome1Element
struct DataModel : Codable {
    let products: [Product]?
    let id: String
    let name: String?
}

// MARK: - Product
struct Product : Codable{
    let id: String
    let imageURL: String?
    let price: Double
    let name, priceText: String
    let shortDescription, category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
}


// MARK: - Main Product Model
struct MainProductModel: Codable {
    let id: String
    let name: String?
    let productCount: Int?
    let products: [MainProduct]?
    let email, password: String?
}

// MARK: - Main Product
struct MainProduct: Codable {
    let id, name: String
    let attribute: String?
    let thumbnailURL, imageURL: String?
    let price: Double
    let priceText: String
    let shortDescription: String?
}
