//
//  MainTabBarViewController.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 16.10.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let home = UINavigationController (rootViewController: HomeViewController())
        let selected = UINavigationController (rootViewController: SelectedViewController())
        let profile = UINavigationController (rootViewController: ProfileViewController())
        
        home.tabBarItem.image = UIImage (systemName: "house")
        selected.tabBarItem.image = UIImage(systemName: "heart")
        profile.tabBarItem.image = UIImage(systemName: "person")
        
        home.title = "Home"
        selected.title = "Selected"
        profile.title = "Profile"
        
        
        tabBar.tintColor = .label
        setViewControllers([home, selected, profile], animated: true)
    }
    
    
}

