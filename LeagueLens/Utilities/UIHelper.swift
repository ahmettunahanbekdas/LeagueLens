//
//  UIHelper.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 2.04.2024.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = CGFloat.deviceWidth
        let padding: CGFloat = 16
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth - (2 * padding), height: cellWidth / 3)
        layout.minimumLineSpacing = 16
        
        return layout
    }
    
    static func createTeamsFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = CGFloat.deviceWidth
        let padding: CGFloat = 16
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth - (2 * padding), height: cellWidth / 3)
        layout.minimumLineSpacing = 3
        

        return layout
    }
    
    
}
