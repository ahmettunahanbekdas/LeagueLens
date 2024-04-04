//
//  TeamsImageView.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 4.04.2024.
//

import Foundation
import UIKit

final class TeamsImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadTeamsImage(id: Int) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.teamsImage(id: id)) else {return}
        dataTask = NetworkManager.shared.download(url: url, headers: headers, completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
