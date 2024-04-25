//
//  ViewController.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import UIKit

protocol ProductListViewControllerProtocol: AnyObject {
    func setupCustomNavigationBar()
    func reloadData()
    func setupCollectionView()
    func setupNavigationBar()
    func setTitle(_ title: String)
    
    
    func showLoading()
//        func hideLoading()
        func displaySuggestedProducts(_ products: [Product])
        func displayMainProducts(_ products: [MainProduct])
        func displayError(message: String)


}

final class ProductListViewController: BaseViewController {
    
    var presenter: ProductListPresenterProtocol!
//    var products: [DataModel] = []
    var suggestedProducts : [Product] = []
    var mainProducts : [MainProduct] = []


    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView(style: .medium)
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
           presenter.viewDidLoad()


    }

    
    func setupCustomNavigationBar() {
        // Özelleştirilmiş navigation bar'ın özellikleri
        let customNavigationBar = UIView()
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0) // Örnek renk
        
        // Navigation bar'a ekleme
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.addSubview(customNavigationBar)
            
            // Constraints ayarla
            customNavigationBar.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor).isActive = true
            customNavigationBar.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor).isActive = true
            customNavigationBar.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
            customNavigationBar.heightAnchor.constraint(equalToConstant: 88).isActive = true // Yükseklik ayarı
            
            // İçerik ayarla (opsiyonel)
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = "Custom Title"
            titleLabel.textColor = .white
            customNavigationBar.addSubview(titleLabel)
            titleLabel.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor).isActive = true
        }
    }

    
}
extension ProductListViewController : ProductListViewControllerProtocol {
    func displaySuggestedProducts(_ products: [Product]) {
        DispatchQueue.main.async {
               self.suggestedProducts = products
               self.collectionView.reloadData()
            print("SUGGESTED PRODUCTS:  \(self.suggestedProducts)")
           }
    }
    
    func displayMainProducts(_ products: [MainProduct]) {
        DispatchQueue.main.async {
               self.mainProducts = products
               self.collectionView.reloadData()
            print("MAIN PRODUCTS:  \(self.suggestedProducts)")
           }
    }
    

    
    func showLoading() {
        activityIndicator.startAnimating()

    }
    
//    func hideLoading() {
//        DispatchQueue.main.async {
//            self.activityIndicator.stopAnimating()
//        }
//    }
    
    
   
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
    }
    
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        setupCustomNavigationBar()
    }
    
    func setupNavigationBar() {
        let containerView = UIView()
        
        // Arka plan rengini ve köşe yuvarlama ayarlarını belirleyin
        containerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        // View boyutunu belirleyin
        containerView.frame = CGRect(x: 0, y: 0, width: 91, height: 34)
        
        // İkon ekle
        let iconImageView = UIImageView(image: UIImage(named: "cartIcon"))
        iconImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        containerView.addSubview(iconImageView)
        
        // Etiket ekle
        let label = UILabel()
        label.text = "tl 0.0"
        label.font = UIFont(name: "Open Sans", size: 14)
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
        label.textAlignment = .center
        label.frame = CGRect(x: 32, y: 0, width: 59, height: 34)
        label.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1.0)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true // This ensures the corner radius works
        label.textAlignment = .center

        containerView.addSubview(label)
        
        // View'ı navigasyon çubuğuna ekleyin
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.barTintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
            navigationBar.layoutIfNeeded() // UINavigationBar'ın hemen yeniden düzenlenmesini sağlar
            // Dokunma işlevi ekle
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cartButtonTapped))
                    containerView.addGestureRecognizer(tapGesture)
            
            let rightBarButtonItem = UIBarButtonItem(customView: containerView)
            navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        }
        
        // Arka plan rengini belirleyin
        view.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
    }

    
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func reloadData() {
        DispatchQueue.main.async{
            self.collectionView.reloadData()
            
            
        }
        
       

        
    }
    @objc func cartButtonTapped(){
        presenter.tappedCartButton()
    }
}
    
extension ProductListViewController : UICollectionViewDelegateFlowLayout{
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(185)
                    ),
                    subitem: item,
                    count: 3
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
                
                
                return section
                
            } else if section == 1 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(185)
                    ),
                    subitem: item,
                    count: 3
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                
                
                return section
            }
            return nil
        }
        
    }
}
    extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(suggestedProducts.count)
            if section == 0 {
                    return suggestedProducts.count
                } else if section == 1 {
                    return mainProducts.count
                }
                return 0        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let layout = ProductCell.Layout(imageHeight: 103.67, nameLabelTopOffset: 4, descriptionLabelTopOffset: 4)
            if indexPath.section == 0 {
                let product = suggestedProducts[indexPath.item]
                cell.configure(with: product, layout: layout)
            } else if indexPath.section == 1 {
                let product = mainProducts[indexPath.item]
                cell.configureMain(with: product, layout: layout)
            }


            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            var selectedSuggestedProduct : Product?
            var selectedProduct : MainProduct?
            
            // Seçilen ürüne ait bilgileri al
                if indexPath.section == 0 && indexPath.row < suggestedProducts.count {
                    selectedSuggestedProduct = suggestedProducts[indexPath.row]
                    if let product = selectedSuggestedProduct {
                            // Seçilen ürünün bilgilerini içeren bir liste oluştur
                            let productInfo: [String: Any] = [
                                "name": product.name ,
                                "description": product.shortDescription ?? "",
                                "imageURL": product.imageURL ?? "",
                                "priceText": product.priceText,
                                "priceDouble": product.price
                            ]
                            
                            // ProductDetailViewController'a giderek bu bilgileri gönder
                            presenter?.didSelectProduct(productInfo)
                        }
                } else if indexPath.section == 1 && indexPath.row < mainProducts.count {
                    selectedProduct = mainProducts[indexPath.row]
                    if let product = selectedProduct {
                            // Seçilen ürünün bilgilerini içeren bir liste oluştur
                            let productInfo: [String: Any] = [
                                "name": product.name ,
                                "description": product.shortDescription ?? "not found"  ,
                                "imageURL": product.imageURL ?? "basket",
                                "priceText": product.priceText,
                                "priceDouble": product.price
                            ]
                            
                            // ProductDetailViewController'a giderek bu bilgileri gönder
                            presenter?.didSelectProduct(productInfo)
                        }
                }
        

            
        }
    }



