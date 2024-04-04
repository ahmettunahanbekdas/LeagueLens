
//
//  LeaguesDetailsViewController.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//

import UIKit

protocol LeaguesDetailsViewControllerInterface: AnyObject {
    func configureView()
    func configureLeagueImageView()
    func configureUILabel()
    func reloadData()
}

class LeaguesDetailsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let viewModel = LeaguesDetailsViewModel()
    
    private var league: ResponseLeague
    private var leagueImageView: LeaguesImageView!
    private var leagueNameLabel: LLTitleLabel!
    
    private let padding: CGFloat = 20
    
    init(league: ResponseLeague) {
        self.league = league
        super.init(nibName: nil, bundle: nil)
        print(self.league.league?.id! as Any)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}



extension LeaguesDetailsViewController: LeaguesDetailsViewControllerInterface {
    
    
    func configureView() {
        view.backgroundColor = .systemBackground
        configureLeagueImageView()
        configureUILabel()
        configureCollectionView()
        
    }
    // MARK: - LİG RESMİ
    func configureLeagueImageView() {
        leagueImageView = LeaguesImageView(frame: .zero)
        view.addSubview(leagueImageView)
        leagueImageView.translatesAutoresizingMaskIntoConstraints = false
        leagueImageView.downloadLeaguesImage(league: league)

        NSLayoutConstraint.activate([
            leagueImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leagueImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            leagueImageView.widthAnchor.constraint(equalToConstant: 150),
            leagueImageView.heightAnchor.constraint(equalTo: leagueImageView.widthAnchor),
        ])
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureUILabel() {
        leagueNameLabel = LLTitleLabel(fontSize: 20)
        leagueNameLabel.text = self.league.league?.name
        
        view.addSubview(leagueNameLabel)
        
        NSLayoutConstraint.activate([
            leagueNameLabel.topAnchor.constraint(equalTo: leagueImageView.bottomAnchor, constant: 20),
            leagueNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leagueNameLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.itemSize = CGSize(width: view.frame.width , height: 50)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(TeamsCollectionViewCell.self, forCellWithReuseIdentifier: TeamsCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: leagueNameLabel.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
        cell.setCell(id: league.league?.id ?? 0)
        return cell
    }
}






















/*
extension LeaguesDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
        cell.backgroundColor = .label
        
        // Örnek olarak her hücreye bir takım adı ekleyelim
        let teamLabel = UILabel()
        teamLabel.text = "Team"
        teamLabel.textColor = .white
        teamLabel.textAlignment = .center
        cell.contentView.addSubview(teamLabel)
        
        
        
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            teamLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }
}
*/
