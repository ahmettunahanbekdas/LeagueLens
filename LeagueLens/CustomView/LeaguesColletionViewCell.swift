import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "LeaguesCell"
    private var league: ResponseLeague!
    
    private let leagueImageView: LeaguesImageView = {
        let leagueImage = LeaguesImageView(frame: .zero)
        leagueImage.tintColor = .label
        leagueImage.contentMode = .scaleAspectFit
        leagueImage.backgroundColor = .green
        return leagueImage
    }()
    
    private let leaguFlagImageView: CountryFlagImageView = {
        let flagImage = CountryFlagImageView(frame: .zero)
        flagImage.tintColor = .label
        flagImage.contentMode = .scaleAspectFit
        flagImage.backgroundColor = .red
        return flagImage
    }()
    
    private let leagueNameLabel = LLTitleLabel(fontSize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(league: ResponseLeague) {
        self.league = league
        leagueImageView.downloadLeaguesImage(league: league)
        leaguFlagImageView.downloadLeagueFlagImage(league: league)
        leagueNameLabel.text = league.league?.name
        

    }

    private func configureCell() {
        addSubview(leaguFlagImageView)

        addSubview(leagueImageView)
        addSubview(leagueNameLabel)
        
        // Ayarlayın ve kısıtlamaları aktif hale getirin
        leagueImageView.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leaguFlagImageView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            // Resim sol tarafta, 40x40 boyutta ve merkezde
            leagueImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            leagueImageView.widthAnchor.constraint(equalToConstant: 60),
            leagueImageView.heightAnchor.constraint(equalToConstant: 60),
            leagueImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Bayrak resmi sol tarafta, 40x40 boyutta ve merkezde
            leaguFlagImageView.leadingAnchor.constraint(equalTo: leagueImageView.trailingAnchor, constant: 8),
            leaguFlagImageView.widthAnchor.constraint(equalToConstant: 40),
            leaguFlagImageView.heightAnchor.constraint(equalToConstant: 40),
            leaguFlagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Etiket resmin sağında ve merkezde
            leagueNameLabel.leadingAnchor.constraint(equalTo: leaguFlagImageView.trailingAnchor, constant: 8),
            leagueNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            leagueNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        // Hücrenin kenarlığını ve köşelerini ayarla
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 16
    }
}
