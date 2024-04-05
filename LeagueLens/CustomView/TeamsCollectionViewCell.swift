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
    
    private let teamsImageView: TeamsImageView = {
        let teamsImage = TeamsImageView(frame: .zero)
        teamsImage.tintColor = .label
        teamsImage.contentMode = .scaleAspectFill
        return teamsImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(id: Int) {
        
        teamsImageView.image = UIImage(named: "chmpleg")

    }

    private func configure() {
        addSubview(teamsImageView)
         
        teamsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        teamsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3 * 8),
        teamsImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5),
        teamsImageView.heightAnchor.constraint(equalTo: teamsImageView.widthAnchor),
        teamsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
        
    layer.borderColor = UIColor.secondaryLabel.cgColor
    layer.borderWidth = 2
    layer.cornerRadius = 20
    }
}
