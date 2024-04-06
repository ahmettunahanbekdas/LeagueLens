//
//  LeaguesImageView.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 1.04.2024.
//

import UIKit

final class LeaguesImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadLeaguesImage(league: ResponseLeague) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.LeaguesImages(id: league.league?.id ?? 0)) else {return}
        
        dataTask = NetworkManager.shared.download(url: url, headers: headers , completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

