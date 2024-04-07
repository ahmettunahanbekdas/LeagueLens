//
//  MakeAlert.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 7.04.2024.
//

import UIKit

enum MakeAlert {
    static func alertMassage(title: String, message: String, style: UIAlertController.Style, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okey", style: .default)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
