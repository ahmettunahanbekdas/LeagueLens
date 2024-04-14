import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "LeaguesCell"
    
    private var league: ResponseLeague!
    private var selectedLeague: ResponseLeague!
    private let leagueNameLabel = TitleLabelHelper(fontSize: 20)
    
    private let leaguePoster: LeagueDownloadPosterImageView = {
        let image = LeagueDownloadPosterImageView(frame: .zero)
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var addFavoriteLeagueButtonTapped: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leagueSetCell(league: ResponseLeague) {
        self.league = league
        selectedLeague = league
        leaguePoster.leagueDownloadLogo(league: league)
        leagueNameLabel.text = league.league?.name
    }
    
    
    @objc private func favoriteButtonTapped() {
        guard let selectedLeague = selectedLeague else {
            print("Error: No league selected")
            return
        }
        DataPersistenceManager.shared.saveLeaguesFavoritesFromDatabase(model: selectedLeague) { result in
            switch result {
            case .success():
                print("League saved successfully")
            case .failure(let error):
                print("Error saving league: \(error)")
            }
        }
    }
    
    private func configureCell() {
        
        addSubview(leaguePoster)
        addSubview(leagueNameLabel)
        addSubview(addFavoriteLeagueButtonTapped)
        
        leaguePoster.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addFavoriteLeagueButtonTapped.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leaguePoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            leaguePoster.widthAnchor.constraint(equalToConstant: 60),
            leaguePoster.heightAnchor.constraint(equalToConstant: 60),
            leaguePoster.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leagueNameLabel.leadingAnchor.constraint(equalTo: leaguePoster.trailingAnchor, constant: 8),
            leagueNameLabel.trailingAnchor.constraint(equalTo: addFavoriteLeagueButtonTapped.leadingAnchor, constant: -8),
            leagueNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addFavoriteLeagueButtonTapped.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addFavoriteLeagueButtonTapped.centerYAnchor.constraint(equalTo: centerYAnchor),
            addFavoriteLeagueButtonTapped.widthAnchor.constraint(equalToConstant: 40),
            addFavoriteLeagueButtonTapped.heightAnchor.constraint(equalToConstant: 40)
        ])
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 16
    }
}
