
import UIKit

final class TeamsDownloadPosterImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func downloadTeamsLogo(id:Int) {
        let headers = Endpoint.APIKey()
        guard let url = URL(string: Endpoint.teamsPosterImageView(id: id)) else {
            return print("downloadTeamsLogo")
            }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                DispatchQueue.main.sync {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                printContent(error.localizedDescription)
            }
        }
    }
}
