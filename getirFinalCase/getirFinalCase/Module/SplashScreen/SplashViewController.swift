//
//  SplashViewController.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 23.04.2024.
//

import Foundation
import UIKit


protocol SplashViewProtocol : AnyObject{
    func noInternerConnection()
}

class SplashViewController: BaseViewController {
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        presenter?.viewDidAppear()
        
        //Customize splash screen UI
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Getir App"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
}
extension SplashViewController: SplashViewProtocol {
    func noInternerConnection() {
        showAlert(title: "Error", message: "No Internet connection, please check your connection")
    }
    
    

}
