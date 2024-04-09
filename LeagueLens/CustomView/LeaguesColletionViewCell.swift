import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "LeaguesCell"
    private var league: ResponseLeague!
    
    private let leagueImageView: LeaguesImageView = {
        let leagueImage = LeaguesImageView(frame: .zero)
        leagueImage.tintColor = .label
        leagueImage.contentMode = .scaleAspectFit
        return leagueImage
    }()
    
    private let leagueNameLabel = LLTitleLabel(fontSize: 20)
    
    private var selectedLeague: ResponseLeague?
    
    private lazy var favoriteButton: UIButton = {
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
    
    func setCell(league: ResponseLeague) {
        self.league = league
        selectedLeague = league
        leagueImageView.downloadLeaguesImage(league: league)
        leagueNameLabel.text = league.league?.name
    }
    
    
    @objc private func favoriteButtonTapped() {
        guard let selectedLeague = selectedLeague else {
            print("Error: No league selected")
            return
        }
        DataPersistenceManager.shared.downloadLeagueWith(model: selectedLeague) { [weak self] result in
            guard let self = self else {
                print("favoriteButtonTapped error")
                return
            }
            switch result {
            case .success():
                print("League saved successfully")
            case .failure(let error):
                print("Error saving league: \(error)")
            }
        }
    }
    
    private func configureCell() {
        addSubview(leagueImageView)
        addSubview(leagueNameLabel)
        addSubview(favoriteButton)
        
        leagueImageView.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leagueImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            leagueImageView.widthAnchor.constraint(equalToConstant: 60),
            leagueImageView.heightAnchor.constraint(equalToConstant: 60),
            leagueImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leagueNameLabel.leadingAnchor.constraint(equalTo: leagueImageView.trailingAnchor, constant: 8),
            leagueNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            leagueNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 16
    }
}


