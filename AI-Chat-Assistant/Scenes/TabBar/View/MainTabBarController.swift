//
//  MainTabBarController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .vcBackground
        tabBar.backgroundColor = .vcBackground
        tabBar.tintColor = .main
        tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }
    


}
