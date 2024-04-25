//
//  CardCell.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import UIKit

class CardCell: UITableViewCell {

    let productImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
           imageView.widthAnchor.constraint(equalToConstant: 74).isActive = true
           imageView.heightAnchor.constraint(equalToConstant: 74).isActive = true
           imageView.layer.cornerRadius = 16
           imageView.layer.borderWidth = 1
           imageView.layer.borderColor = UIColor.lightGray.cgColor
           return imageView
       }()
       
       let nameLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
           return label
       }()
       
       let priceLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 14)
           label.textColor = .gray
           return label
       }()
       
       let descriptionLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 14)
           label.textColor = .gray
           return label
       }()
    
    let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        // Shadow
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 6
            view.layer.shadowOpacity = 0.1
        
        // Trash Symbol
        let trashImageView = UIImageView(image: UIImage(systemName: "trash"))
        trashImageView.tintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        trashImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trashImageView)
        NSLayoutConstraint.activate([
            trashImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            trashImageView.widthAnchor.constraint(equalToConstant: 18),
            trashImageView.heightAnchor.constraint(equalToConstant: 18),
        ])
        
        // Middle Label
        let numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.systemFont(ofSize: 14)
        numberLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        numberLabel.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)

        numberLabel.text = "1"
        numberLabel.layer.masksToBounds = true // This ensures the corner radius works
        numberLabel.textAlignment = .center
        view.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 38),
            numberLabel.heightAnchor.constraint(equalToConstant: 32)

        ])
        
        // Plus Symbol
        let plusImageView = UIImageView(image: UIImage(systemName: "plus"))
        plusImageView.tintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusImageView)
        NSLayoutConstraint.activate([
            plusImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            plusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 18),
            plusImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        return view
    }()

       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
           
           func setupViews() {
                   contentView.addSubview(productImageView)
                   contentView.addSubview(nameLabel)
                   contentView.addSubview(priceLabel)
                   contentView.addSubview(descriptionLabel)
                   contentView.addSubview(customView)
                   
                   NSLayoutConstraint.activate([
                       productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                       productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                       productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                       
                       nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                       nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
                       nameLabel.trailingAnchor.constraint(equalTo: customView.leadingAnchor, constant: -10),
                       
                       priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                       priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                       
                       descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
                       descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                       descriptionLabel.trailingAnchor.constraint(equalTo: customView.leadingAnchor, constant: -10),
                       
                       customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                       customView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                       customView.widthAnchor.constraint(equalToConstant: 102),
                       customView.heightAnchor.constraint(equalToConstant: 32)
                   ])
               }
       
      
   }
