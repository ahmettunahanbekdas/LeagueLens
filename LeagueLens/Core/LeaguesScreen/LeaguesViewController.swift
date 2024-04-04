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
    func navigationToDetailsLeague(league: ResponseLeague)
}
import UIKit

class LeaguesViewController: UIViewController {
    
    private let viewModel = LeaguesViewModel()
    var collectionView: UICollectionView!
    
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LeaguesCollectionViewCell.self, forCellWithReuseIdentifier: LeaguesCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }

    func navigationToDetailsLeague(league: ResponseLeague) {
        let detailVC = LeaguesDetailsViewController(league: league)
        navigationController?.pushViewController(detailVC, animated: true)
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
        // Hücre boyutunu ayarlayın, örneğin:
        let width = collectionView.frame.width - 20
        let height: CGFloat = 100 // Örnek bir yükseklik, isteğinize göre ayarlayabilirsiniz
        return CGSize(width: width, height: height)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.leagueDidSelected(at: indexPath)
        
    }

}
