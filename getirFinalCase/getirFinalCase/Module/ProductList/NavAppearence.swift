//
//  NavAppearence.swift
//  usageCompositionalLayout
//
//  Created by Pinar Talas on 22.04.2024.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setUpBarColor(){
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        self.navigationBar.standardAppearance = appearence
        self.navigationBar.scrollEdgeAppearance = appearence
        self.navigationBar.compactAppearance = appearence
        
        self.navigationBar.tintColor = .white
        UIBarButtonItem.appearance().tintColor = .white
    }
}
