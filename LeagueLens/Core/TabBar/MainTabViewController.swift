//
//  MainTabViewController.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 29.03.2024.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Run App")
        
        // TabBar Views atandı.
        let vc1 = UINavigationController(rootViewController: LeaguesViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: FavoritesViewController())
        
        // TabBar Images eklendi.
        vc1.tabBarItem.image = UIImage(systemName: "soccerball.inverse")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "heart.fill")
        
       //tabBar.tintColor = .label
       //tabBar.backgroundColor = .systemGray3
        
        // TabBar Title.
        vc1.title = "Leagues"
        vc2.title =  "Search"
        vc3.title = "Favorites"
        
        // TabBar'a set edildi.
        setViewControllers([vc2, vc1, vc3] , animated: true)
        
    }
}
