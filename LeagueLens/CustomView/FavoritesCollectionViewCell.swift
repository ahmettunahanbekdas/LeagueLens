import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let reuseID = "FavoritesCell"
    
    private let favoritesLeaguesNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    
    private let favoriteLeaguesLogoImageView: LeagueDownloadPosterImageView = {
        let leagueImage = LeagueDownloadPosterImageView(frame: .zero)
        leagueImage.tintColor = .label
        leagueImage.contentMode = .scaleAspectFit
        return leagueImage
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureFavoritesCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func favoritesLeaguesSetCell(leaguesItem: TitleItem) {
        favoritesLeaguesNameLabel.text = leaguesItem.name
        favoriteLeaguesLogoImageView.favoriteLeagueDownloadLogo(league: leaguesItem)
        
    }
    
    private func configureFavoritesCollectionViewCell() {
        addSubview(favoritesLeaguesNameLabel)
        addSubview(favoriteLeaguesLogoImageView)
        
        favoritesLeaguesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteLeaguesLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteLeaguesLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favoriteLeaguesLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteLeaguesLogoImageView.widthAnchor.constraint(equalToConstant: 80),
            favoriteLeaguesLogoImageView.heightAnchor.constraint(equalToConstant: 80),

            favoritesLeaguesNameLabel.leadingAnchor.constraint(equalTo: favoriteLeaguesLogoImageView.trailingAnchor, constant: 16),
            favoritesLeaguesNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoritesLeaguesNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
