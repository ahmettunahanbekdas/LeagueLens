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
        
        let viewControllerOne = UINavigationController(rootViewController: LeaguesViewController())
        let viewControllerOneTwo = UINavigationController(rootViewController: FavoritesLeaguesViewController())
        
        viewControllerOne.tabBarItem.image = UIImage(systemName: "soccerball.inverse")
        viewControllerOneTwo.tabBarItem.image = UIImage(systemName: "heart.fill")
                
        viewControllerOne.title = "Leagues"
        viewControllerOneTwo.title = "Favorites"
        
        setViewControllers([viewControllerOne, viewControllerOneTwo] , animated: true)
    }
}
