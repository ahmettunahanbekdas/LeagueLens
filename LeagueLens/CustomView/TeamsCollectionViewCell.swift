//
//  TeamsCollectionViewCell.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 4.04.2024.
//

import UIKit

final class TeamsCollectionViewCell: UICollectionViewCell {
    static let reuseID = "TeamsCell"
    private var teams:  LeagueStanding!
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamsImageView: TeamsImageView = {
        let imageView = TeamsImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(teamName: String, teamID: Int) {
        teamNameLabel.text = teamName
        teamsImageView.downloadTeamsImage(id: teamID)
    }
    
    private func configure() {
        addSubview(teamsImageView)
        addSubview(teamNameLabel)
        
        NSLayoutConstraint.activate([
            // TeamsImageView
            teamsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamsImageView.widthAnchor.constraint(equalToConstant: 60), // Örneğin, resmin sabit bir genişliği olduğunu varsayalım
            teamsImageView.heightAnchor.constraint(equalTo: teamsImageView.widthAnchor),
            
            // TeamNameLabel
            teamNameLabel.leadingAnchor.constraint(equalTo: teamsImageView.trailingAnchor, constant: 8),
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
    }
}
