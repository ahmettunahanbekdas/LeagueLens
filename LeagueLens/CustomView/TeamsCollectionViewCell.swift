
import UIKit

final class TeamsCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "TeamsCell"
    
    private var teams:  LeagueStanding!
    
    private let teamsRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamsPoster: TeamsDownloadPosterImageView = {
        let image = TeamsDownloadPosterImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let teamsWinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamsDrawLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let teamsLoseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let teamsPointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let teamsFormLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTeamsCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTeamsCell(rank: Int, teamImage: Int, teamName: String, win:Int, draw: Int, lose: Int, points: Int, form: String) {
        teamNameLabel.text = teamName
        teamsPoster.downloadTeamsLogo(id: teamImage)
        teamsRankLabel.text = "\(rank)."
        teamsPointLabel.text = "P: \(points)"
        teamsLoseLabel.text = "L: \(lose)"
        teamsDrawLabel.text = "D: \(draw)"
        teamsWinLabel.text = "W: \(win)"
        teamsFormLabel.text = form
    }
    
    private func configureTeamsCollectionViewCell() {
        addSubview(teamsRankLabel)
        addSubview(teamsPoster)
        addSubview(teamNameLabel)
        addSubview(teamsWinLabel)
        addSubview(teamsDrawLabel)
        addSubview(teamsLoseLabel)
        addSubview(teamsPointLabel)
        addSubview(teamsFormLabel)
        
        let padding: CGFloat = .deviceWidth
        
        
        NSLayoutConstraint.activate([
            teamsRankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding/80),
            teamsRankLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsPoster.leadingAnchor.constraint(equalTo: teamsRankLabel.trailingAnchor, constant: padding/80),
            teamsPoster.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamsPoster.widthAnchor.constraint(equalToConstant: padding/15),
            teamsPoster.heightAnchor.constraint(equalTo: teamsPoster.widthAnchor),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamsPoster.trailingAnchor, constant: padding/80),
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamNameLabel.widthAnchor.constraint(equalToConstant: padding/6),
            
            teamsWinLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding/3),
            teamsWinLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsDrawLabel.leadingAnchor.constraint(equalTo: teamsWinLabel.trailingAnchor, constant: padding/40),
            teamsDrawLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsLoseLabel.leadingAnchor.constraint(equalTo: teamsDrawLabel.trailingAnchor, constant: padding/40),
            teamsLoseLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsPointLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding/5),
            teamsPointLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsFormLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding/80),
            teamsFormLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
}
