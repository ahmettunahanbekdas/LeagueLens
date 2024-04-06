//
//  ViewController.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 29.03.2024.
//

import UIKit

protocol LeaguesViewControllerInterface: AnyObject {
    func configureLeaguesView()
    func reloadData()
    func navigationToDetailsLeagues(leagueDetail: [LeagueStanding])

}

class LeaguesViewController: UIViewController {
    
    private let viewModel = LeaguesViewModel()
    var collectionView: UICollectionView!
    var currentPage = 1
       let pageSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension LeaguesViewController: LeaguesViewControllerInterface {
    func configureLeaguesView() {
        configureCollectionView()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTeamsFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LeaguesCollectionViewCell.self, forCellWithReuseIdentifier: LeaguesCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    func navigationToDetailsLeagues(leagueDetail: [LeagueStanding]) {
        DispatchQueue.main.async {
            let detailsLeague = LeaguesDetailsViewController(league: leagueDetail)
            self.navigationController?.pushViewController(detailsLeague, animated: true)
        }
    }
}

extension LeaguesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.leagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaguesCollectionViewCell.reuseID, for: indexPath) as! LeaguesCollectionViewCell
        cell.setCell(league: viewModel.leagues[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectedLeaguesDetail(id: viewModel.leagues[indexPath.item].league?.id ?? 0 )
    }
}
