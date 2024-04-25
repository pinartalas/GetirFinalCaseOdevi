//
//  ProductListInteractor.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import Foundation

protocol ProductListInteractorProtocol {
    func fetchSuggestedProducts()
    func fetchProducts()
}

protocol ProductListInteractorOutputProtocol : AnyObject {
    func suggestedProductsFetched(_ products: [Product])
    func MainProductsFetched(_ mainProducts: [MainProduct])

    func fetchFailed(with error: Error)
//    func fetchMainFailed(with error: Error)
}


final class ProductListInteractor {
    weak var output: ProductListInteractorOutputProtocol?
    
    
   }
// MARK: - Protocols

extension ProductListInteractor: ProductListInteractorProtocol {
    

        func fetchSuggestedProducts() {
            guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts") else {
                self.output?.fetchFailed(with: InteractorError.invalidURL)
                return
            }

            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }

                if let error = error {
                    self.output?.fetchFailed(with: error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.output?.fetchFailed(with: InteractorError.invalidResponse)
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    self.output?.fetchFailed(with: InteractorError.invalidResponse)
                    return
                }

                guard let data = data else {
                    self.output?.fetchFailed(with: InteractorError.noData)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let dataModels = try decoder.decode([DataModel].self, from: data)
                    print("Alınan veriler: \(dataModels)") // Alınan verileri konsola yazdır
                                    
                                    // Tüm suggestedProducts'ları birleştir
                                    var allProducts: [Product] = []
                                    for dataModel in dataModels {
                                        if let products = dataModel.products {
                                            allProducts.append(contentsOf: products)
                                        }
                                    }
                    print("allProductsssss : /(allProducts)")
                    self.output?.suggestedProductsFetched(allProducts)
                    
                } catch {
                    self.output?.fetchFailed(with: error)
                }
            }.resume()
        }
    
    func fetchProducts(){
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/products") else {
            self.output?.fetchFailed(with: InteractorError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                self.output?.fetchFailed(with: error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.output?.fetchFailed(with: InteractorError.invalidResponse)
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                self.output?.fetchFailed(with: InteractorError.invalidResponse)
                return
            }

            guard let data = data else {
                self.output?.fetchFailed(with: InteractorError.noData)
                return
            }

            do {
                let decoder = JSONDecoder()
                   let mainProductModels = try decoder.decode([MainProductModel].self, from: data)
                   var allProducts: [MainProduct] = []
                   for mainProductModel in mainProductModels {
                       if let products = mainProductModel.products {
                           allProducts.append(contentsOf: products)
                       }
                   }

                   // Tüm ürünler listesi
                   print("Tüm ürünler:")
                   for product in allProducts {
                       print("Ürün adı: \(product.name), Fiyatı: \(product.price)")
                   }
                self.output?.MainProductsFetched(allProducts)

//                          if let products = mainProductModel.products {
//                              // products dizisindeki her bir ürünü allProducts dizisine ekleyin
//                              allProducts.append(contentsOf: products)
//                          }
//
//                          // Tüm ürünler listesi
//                          print("Tüm ürünler:")
//                          for product in allProducts {
//                              print("Ürün adı: \(product.name), Fiyatı: \(product.price)")
//                          }
//                self.output?.MainProductsFetched(allProducts)

            } catch {
//                self.output?.fetchMainFailed(with: error)
                
                print("BURDA HATA VAR ")
            }
        }.resume()
    }

}


// MARK: - Error Handling

enum InteractorError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

