//
//  CardCollectionCell.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import UIKit

class CardCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "CardCollectionCell"
        
        let productImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 92).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 92).isActive = true
            imageView.layer.cornerRadius = 16
            imageView.layer.borderWidth = 1
            let hexColor = UIColor(red: 0xF2/255.0, green: 0xF0/255.0, blue: 0xFA/255.0, alpha: 1.0)
            imageView.layer.borderColor = hexColor.cgColor // Gri tonunu belirleyin
            return imageView
        }()
        
        let nameLabel: UILabel = {
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
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            
           
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupViews() {
            contentView.addSubview(productImageView)
            contentView.addSubview(nameLabel)
            contentView.addSubview(priceLabel)
            contentView.addSubview(descriptionLabel)
            
            NSLayoutConstraint.activate([
                productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                
                nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
               
                
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    
    
}
