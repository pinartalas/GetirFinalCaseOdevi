//
//  ProductCell.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import UIKit

struct CardProduct {
    let name: String
    let imageURL: String?
    let description: String
    let priceText: String!
    let price : Double!
}
var cardProducts: [CardProduct] = []


class ProductCell: UICollectionViewCell {
    var price: Double = 0
    
     // Hücrelerin bilgilerini saklamak için bir dizi oluştur

    
    struct Layout {
        let imageHeight: CGFloat
        let nameLabelTopOffset: CGFloat
        let descriptionLabelTopOffset: CGFloat
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Kenarlık ve köşe yuvarlama ayarları
        imageView.layer.borderWidth = 1.0
        
        // Verilen hex renk kodunu RGB bileşenlerine dönüştürme
        let hexColor = UIColor(red: 0xF2/255.0, green: 0xF0/255.0, blue: 0xFA/255.0, alpha: 1.0)
        imageView.layer.borderColor = hexColor.cgColor // Gri tonunu belirleyin
        
        imageView.layer.cornerRadius = 10.0 // Köşe yuvarlama
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 12) // Yazı tipi ve boyutunu belirt
        label.textColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0) // Renk: RGBA formatıyla
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 14) // Yazı tipini ve boyutunu belirt
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0) // Renk: RGBA formatıyla
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 12) // Yazı tipi ve boyutunu belirt
        label.textColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1.0) // Renk: RGBA formatıyla
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var plusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha:1)
        imageView.layer.cornerRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOpacity = 0.1
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(descriptionLabel)
        addSubview(plusIcon)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusIconTapped))
        plusIcon.addGestureRecognizer(tapGesture)
        plusIcon.isUserInteractionEnabled = true // Dokunma etkinleştirme
        
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        plusIcon.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        plusIcon.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -15).isActive = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //               nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //               descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),        ])
    }
    
    
    func updateTotalPrice() {
        var totalPrice: Double = 0
        
        // cardProducts dizisindeki her ürün için fiyatları topla
        for product in cardProducts {
            totalPrice += price
        }
        
        // Toplam fiyatı yazdır
        print("TOPLAM FIYAT: ", totalPrice)
    }

    @objc func plusIconTapped() {
        
        let cardProduct = CardProduct(name: titleLabel.text ?? "", imageURL: "", description: descriptionLabel.text ?? "", priceText: priceLabel.text!, price: price)
        
        // Oluşturulan örneği dizimize ekleyin
        cardProducts.append(cardProduct)

        updateTotalPrice()
        
        
        // Artı simgesinin yerine gelecek başka bir simge oluşturun
        let newIcon = UIImageView(image: UIImage(named: "Stepper"))
        newIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Yeni simgeyi ekleyin
        addSubview(newIcon)
        
        NSLayoutConstraint.activate([
            newIcon.widthAnchor.constraint(equalToConstant: 32),
            newIcon.heightAnchor.constraint(equalToConstant: 96),
            newIcon.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            newIcon.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -15)
        ])
        
        // Eski artı simgesini kaldırın
        plusIcon.removeFromSuperview()
        
        // Yeni bir CardProduct örneği oluşturun
             
        
        // İsteğe bağlı olarak, yeni simgeye tekrar tıklanabilirlik ekleyebilirsiniz
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(newIconTapped))
        newIcon.addGestureRecognizer(tapGesture)
        newIcon.isUserInteractionEnabled = true
    }
    @objc func newIconTapped() {
        // Yeni simgeye tıklanıldığında yapılacak işlemleri buraya ekleyin
        print("New icon tapped!")
    }
    func configure(with product: Product, layout: ProductCell.Layout) {
        // Set price label
        self.priceLabel.text = product.priceText
        // Set title label
        self.titleLabel.text = product.name
        // Set description label
        self.descriptionLabel.text = product.shortDescription
        
        var price = product.price
        
        // Load image asynchronously
        if let imageURLString = product.imageURL, let imageURL = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        // Resmi ana kuyruğa geri dönerek ayarla
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            self.imageView.image = nil
        }
    

    

        imageView.heightAnchor.constraint(equalToConstant: layout.imageHeight).isActive = true
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: layout.nameLabelTopOffset).isActive = true
            // priceLabel'in üst kenarı, productImageView'ın alt kenarına bir boşluk ekleyerek ayarlanıyor
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: layout.descriptionLabelTopOffset).isActive = true
            // nameLabel'in üst kenarı, priceLabel'in alt kenarına bir boşluk ekleyerek ayarlanıyor
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: layout.descriptionLabelTopOffset).isActive = true
            // descriptionLabel'in üst kenarı, nameLabel'in alt kenarına bir boşluk ekleyerek ayarlanıyor
        }
    func configureMain(with product: MainProduct, layout: ProductCell.Layout) {
        // Set price label
        self.priceLabel.text = product.priceText
        // Set title label
        self.titleLabel.text = product.name
        // Set description label
        self.descriptionLabel.text = product.shortDescription
        
        // Load image asynchronously
        if let imageURLString = product.imageURL, let imageURL = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        // Resmi ana kuyruğa geri dönerek ayarla
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            self.imageView.image = nil
        }
    

    

        imageView.heightAnchor.constraint(equalToConstant: layout.imageHeight).isActive = true
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: layout.nameLabelTopOffset).isActive = true
            // priceLabel'in üst kenarı, productImageView'ın alt kenarına bir boşluk ekleyerek ayarlanıyor
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: layout.descriptionLabelTopOffset).isActive = true
            // nameLabel'in üst kenarı, priceLabel'in alt kenarına bir boşluk ekleyerek ayarlanıyor
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: layout.descriptionLabelTopOffset).isActive = true
            // descriptionLabel'in üst kenarı, nameLabel'in alt kenarına bir boşluk ekleyerek ayarlanıyor
        }

}
