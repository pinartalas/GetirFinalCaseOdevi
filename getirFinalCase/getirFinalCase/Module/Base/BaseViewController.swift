//
//  BaseViewController.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import UIKit

class BaseViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarColor()
        let backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)

        view.backgroundColor = backgroundColor
        
       

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    func setUpNavigationBarColor() {
           if let navigationController = self.navigationController {
               navigationController.setUpBarColor()
           }
       }
}
