
import UIKit

final class LeagueDownloadPosterImageView: UIImageView {
    private var dataTask: URLSessionDataTask?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leagueDownloadLogo(league: ResponseLeague) {
        let headers = Endpoint.APIKey()
        guard let url = URL(string: Endpoint.leaguesPosterImageView(id: league.league?.id ?? 0)) else {return}
        
        NetworkManager.shared.download(url: url, headers: headers , completion: { [weak self] result in
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
    
    func favoriteLeagueDownloadLogo(league: TitleItem) {
        let headers = Endpoint.APIKey()
        guard let url = URL(string: Endpoint.leaguesPosterImageView(id: Int(league.id))) else {return}
        
         NetworkManager.shared.download(url: url, headers: headers , completion: { [weak self] result in
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
