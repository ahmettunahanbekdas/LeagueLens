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
    
    private let rankLabel: UILabel = {
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
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let winLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let drawLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let loseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15) // Kalın yazı tipi ayarı
        return label
    }()
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(rank: Int, teamImage: Int, teamName: String, win:Int, draw: Int, lose: Int, points: Int, form: String) {
        teamNameLabel.text = teamName
        teamsImageView.downloadTeamsImage(id: teamImage)
        rankLabel.text = "\(rank)."
        pointsLabel.text = "P: \(points)"
        loseLabel.text = "L: \(lose)"
        drawLabel.text = "D: \(draw)"
        winLabel.text = "W: \(win)"
        formLabel.text = form
    }
    
    private func configure() {
        addSubview(rankLabel)
        addSubview(teamsImageView)
        addSubview(teamNameLabel)
        addSubview(winLabel)
        addSubview(drawLabel)
        addSubview(loseLabel)
        addSubview(pointsLabel)
        addSubview(formLabel)
        
        let padding: CGFloat = .deviceWidth
        
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding/80),
            rankLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            teamsImageView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: padding/80),
            teamsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamsImageView.widthAnchor.constraint(equalToConstant: padding/15),
            teamsImageView.heightAnchor.constraint(equalTo: teamsImageView.widthAnchor),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamsImageView.trailingAnchor, constant: padding/80),
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamNameLabel.widthAnchor.constraint(equalToConstant: padding/6), // Örnek bir genişlik

            winLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding/3),
            winLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            drawLabel.leadingAnchor.constraint(equalTo: winLabel.trailingAnchor, constant: padding/40),
            drawLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loseLabel.leadingAnchor.constraint(equalTo: drawLabel.trailingAnchor, constant: padding/40),
            loseLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pointsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding/5),
            pointsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            formLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding/80),
            formLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }}

