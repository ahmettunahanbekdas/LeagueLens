//
//  SearchResultViewController.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 8.04.2024.
//

import UIKit

protocol SearchResultViewControllerInterface: AnyObject {
    func configureResultCollectionView() 

}

class SearchResultViewController: UIViewController {

    private let viewModel =  SearchResultViewModel()
    var searchLeagues: [ResponseLeague] = []

     let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: .deviceWidth , height: .deviceHeight/6)
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LeaguesCollectionViewCell.self, forCellWithReuseIdentifier: LeaguesCollectionViewCell.reuseID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

extension SearchResultViewController:  SearchResultViewControllerInterface{
    func configureResultCollectionView() {
        view.backgroundColor = .red
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.frame = view.bounds
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchLeagues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaguesCollectionViewCell.reuseID, for: indexPath) as? LeaguesCollectionViewCell else {
                return LeaguesCollectionViewCell()
        }
        cell.backgroundColor = .systemRed
        let league = searchLeagues[indexPath.row]
        cell.allLeagueSetCell(league: league)
      return cell
    }

}
// TIKLAMA İŞİ 4.23 TE VAR
