//
//  UIView+Ext.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 2.04.2024.
//

import UIKit

extension UIView {
    func pinToEdgesOfSafeArea(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
