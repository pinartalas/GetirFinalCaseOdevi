//
//  ProductDetailView.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol : AnyObject {
    
    func setUpUI()
    func setTitle(_ title: String)
    func setUpNavBar()
    func addToCartButtonTapped()
    func setProductInfo(_ info: [String: Any])
}

final class ProductDetailView: BaseViewController {
    
    var presenter: ProductDetailPresenterProtocol!
    
    // UI elements
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray3 // veya istediğiniz herhangi bir renk
        
        // Shadow özelliklerini ayarla
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.1
        
        return view
    }()
    
        let productImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit // or any other content mode you prefer
            imageView.layer.cornerRadius = 16
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            return imageView
        }()

        let priceLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont(name: "OpenSans-Bold", size: 14) // Yazı tipini ve boyutunu belirt
            label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0) // Renk: RGBA formatıyla
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let productNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "OpenSans-SemiBold", size: 16)
            label.textColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0) // Renk: RGBA formatıyla
            label.textAlignment = .center
            return label
        }()

        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
            label.textColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1.0) // Renk: RGBA formatıyla
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
    
    // Navigation Bar
    let tabBar : UITabBar = {
        let navBar = UITabBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navBar.layer.shadowColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 0.12).cgColor
        navBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        navBar.layer.shadowRadius = 8
        navBar.layer.shadowOpacity = 1
        return navBar
    }()
    
    let addToCartButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Sepete Ekle", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
            button.layer.cornerRadius = 10
        button.addTarget(ProductDetailView.self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
            return button
        }()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let router = ProductDetailRouter()
//        let interactor = ProductDetailInteractor()
//        presenter = ProductDetailPresenter(view: self, router: router, interactor: interactor)
        presenter.viewDidLoad()
    }
//    @objc private func addToCartButtonTapped() {
//            // Handle addToCart button tap
//        }
}

extension ProductDetailView : ProductDetailViewProtocol{
    
    @objc func addToCartButtonTapped() {
        //Butona basildiginda sepet sayfasina gidicek gene router ile yap
    }
    

    
    func setUpNavBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName : "arrow.left"), style: .plain, target: self, action: #selector(goProductListPage))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setUpUI() {
        view.backgroundColor = .white // or any other color you prefer

                // Add subviews
                view.addSubview(borderView)
                view.addSubview(productImageView)
                view.addSubview(priceLabel)
                view.addSubview(productNameLabel)
                view.addSubview(descriptionLabel)
                view.addSubview(tabBar)
                view.addSubview(addToCartButton)


                // Constraints
                NSLayoutConstraint.activate([
                    borderView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    borderView.heightAnchor.constraint(equalToConstant: 1), // Kalınlık ayarlayabilirsiniz,
                        
                    
                    productImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                    productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    productImageView.widthAnchor.constraint(equalToConstant: 200),
                    productImageView.heightAnchor.constraint(equalToConstant: 200),

                    priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
                    priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                    productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
                    productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                    descriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
                    descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    
                    
                    tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    tabBar.heightAnchor.constraint(equalToConstant: 100), // Standart navigation bar
                    

                    addToCartButton.widthAnchor.constraint(equalToConstant: 343),
                    addToCartButton.heightAnchor.constraint(equalToConstant: 50),
                    addToCartButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
                    addToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
                    
                ])
        
            }
    
    func setProductInfo(_ info: [String: Any]) {
        if let imageURLString = info["imageURL"] as? String {
            if let imageURL = URL(string: imageURLString) {
                let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.productImageView.image = image
                        }
                    } else {
                        print("Failed to load image:", error ?? "Unknown error")
                    }
                }
                task.resume()
            } else {
                print("Invalid image URL:", imageURLString)
            }
        } else {
            print("Image URL not found")
        }
          if let priceText = info["priceText"] as? String {
              // Fiyatı ayarla
              priceLabel.text = priceText
          }
          if let name = info["name"] as? String {
              // Ürün adını ayarla
              productNameLabel.text = name
          }
          if let description = info["description"] as? String {
              // Açıklamayı ayarla
              descriptionLabel.text = description
          }
      }
    @objc private func goProductListPage() {
        presenter.tappedLeftArrow()
    }
    
    }
    

