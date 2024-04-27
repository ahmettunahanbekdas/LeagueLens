import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {

    weak var vc: LeaguesViewController?
    weak var searchVC: SearchResultViewController?
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
        DataPersistenceManager.shared.saveLeaguesFavoritesFromDatabase(model: selectedLeague) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                if let viewController = self.vc {
                    MakeAlertHelper.alertMassage(action: "Okay", title: "Success", message: "League Added Favorites", style: .alert, vc: viewController)
                } else {
                    MakeAlertHelper.alertMassage(action: "Okay", title: "Success", message: "League Added Favorites", style: .alert, vc: self.searchVC!)
                }
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


/*
 @objc private func favoriteButtonTapped() {
     guard let selectedLeague = selectedLeague else {
         print("Error: No league selected")
         return
     }
     
     isFavorite.toggle()
     
     // Favori durumuna göre yıldız butonunun görünümünü değiştir
     let starImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
     addFavoriteLeagueButtonTapped.setImage(starImage, for: .normal)
     
     // Favori ekleme veya silme işlemini gerçekleştir
     if isFavorite {
         // Favoriye ekleme işlemi
         DataPersistenceManager.shared.saveLeaguesFavoritesFromDatabase(model: selectedLeague) { result in
             switch result {
             case .success():
                 print("League saved successfully")
             case .failure(let error):
                 print("Error saving league: \(error)")
             }
         }
     } else {
         // Favoriden çıkarma işlemi
         DataPersistenceManager.shared.fetchingFavoritesLeaguesFromDataBase { result in
             switch result {
             case .success(let favoriteLeagues):
                 // Favori ligler arasında seçilen ligi bul
                 if let favoriteLeague = favoriteLeagues.first(where: { $0.id == selectedLeague.league?.id ?? 0}) {
                     // Lig bulundu, favorilerden çıkar
                     DataPersistenceManager.shared.deleteFavoritesLeaguFromDatabase(model: favoriteLeague) { result in
                         switch result {
                         case .success():
                             print("League removed from favorites successfully")
                         case .failure(let error):
                             print("Error removing league from favorites: \(error)")
                         }
                     }
                 }
             case .failure(let error):
                 print("Error fetching favorite leagues: \(error)")
             }
         }
     }
 }
 */
