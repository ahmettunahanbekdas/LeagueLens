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
    private let services = Services()
    var collectionView: UICollectionView!
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search League"
        controller.searchBar.searchBarStyle = .prominent
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension LeaguesViewController: LeaguesViewControllerInterface {
    func configureLeaguesView() {
        configureCollectionView()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.tintColor = .label
        searchController.searchResultsUpdater = self
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
            guard !leagueDetail.isEmpty else {
                MakeAlert.alertMassage(title: "League Detail Not Found", message: "Continue For Other Leagues", style: .alert, vc: self)
                return
            }
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
        let width = collectionView.frame.width - .deviceWidth / 20
        let height: CGFloat = .deviceHeight / 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectedLeaguesDetail(id: viewModel.leagues[indexPath.item].league!._id )
    }
}

extension LeaguesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
           
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
            print("updateSearchResults Error")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.services.search(with: query) { [weak resultController] results in
                DispatchQueue.main.async {
                    guard let searchResults = results else {
                        // Handle the case when results is nil
                        // For example, display an error message to the user
                        return
                    }
                    resultController?.searchLeagues = searchResults
                    resultController?.searchResultCollectionView.reloadData()
                }
            }
        }
    }
}




//func getLeagues() {
//    services.downloadLeagues { [weak self] returnedLeagues in
//        guard let self = self else {
//            print("Error")
//            return
//        }
//        guard let returnedLeagues = returnedLeagues else {
//            print("returnedLeagues")
//            return
//        }
//        self.leagues.append(contentsOf: returnedLeagues)
//        self.view?.reloadData()
//    }
//}
