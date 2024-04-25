//
//  CardViewController.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation
import UIKit

protocol CardViewControllerProtocol : AnyObject {
//    func setupCollectionView()
    func setTitle(_ title: String)
    func setUpViews()
}

final class CardViewController : BaseViewController {
    
    var productsTableView: UITableView!
    var recommendedCollectionView: UICollectionView!
    var presenter: CardPresenterProtocol!
    
    let productsCard: [Products] = [
        Products(name: "Ürün 1", imageName: "basket", price: 19.99, description: "Attribute"),
        Products(name: "Ürün 2", imageName: "basket", price: 19.99, description: "Attribute"),
        Products(name: "Ürün 3", imageName: "basket", price: 19.99, description: "Attribute"),
        Products(name: "Ürün 3", imageName: "basket", price: 19.99, description: "Attribute"),
        Products(name: "Ürün 3", imageName: "basket", price: 19.99, description: "Attribute"),
        Products(name: "Ürün 3", imageName: "basket", price: 19.99, description: "Attribute"),

    ]
    
    let recommendedProducts: [SuggestProduct] = [
        SuggestProduct(name: "Ürün 1", imageName: "basket", price: 29.99, description: "Attribute"),
        SuggestProduct(name: "Ürün 2", imageName: "basket", price: 29.99, description: "Attribute"),
        SuggestProduct(name: "Ürün 3", imageName: "basket", price: 29.99, description: "Attribute")
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50 // Bu, varsayılan tahmini hücre yüksekliğidir
        tableView.register(CardCell.self, forCellReuseIdentifier: "CardCell")


        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: "CardCollectionCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let recommendLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Önerilen Ürünler"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
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
            button.setTitle("Siparişi Tamamla", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
            button.layer.cornerRadius = 10
        button.addTarget(ProductDetailView.self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
            return button
        }()
    
    @objc func addToCartButtonTapped() {
        //Butona basildiginda sepet sayfasina gidicek gene router ile yap
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
//
    }



extension CardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"CardCell", for: indexPath) as! CardCell
        let product = productsCard[indexPath.row]
        cell.productImageView.image = UIImage(named: product.imageName)
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "$\(product.price)"
        cell.descriptionLabel.text = product.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // İstenen boşluk miktarını döndürün
        return 95 // Örneğin, hücreler arasında 100 birimlik bir boşluk olsun
    }
}

extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CardCollectionCell", for: indexPath) as! CardCollectionCell
           let product = recommendedProducts[indexPath.item]
           cell.productImageView.image = UIImage(named: product.imageName)
           cell.nameLabel.text = product.name
           cell.priceLabel.text = "$\(product.price)"
           cell.descriptionLabel.text = product.description
           return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 150)
        }
   }


extension CardViewController : CardViewControllerProtocol{
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        view.addSubview(recommendLabel)
        view.addSubview(collectionView)
        view.addSubview(tabBar)
        view.addSubview(addToCartButton)

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 285),
                    
                    recommendLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
                    recommendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                    recommendLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12),
                    
                    collectionView.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor, constant: 12),
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    collectionView.heightAnchor.constraint(equalToConstant: 190),
            
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 100), // Standart navigation bar
            addToCartButton.widthAnchor.constraint(equalToConstant: 343),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
            
                    

            
            

            ]
        )

    }
    

 

}
