
import UIKit

protocol LeaguesViewControllerInterface: AnyObject {
    func configureLeaguesView()
    func reloadData()
    func navigationToDetailsLeagues(leagueDetails: [LeagueStanding])
}

class LeaguesViewController: UIViewController {
    
    private let viewModel = LeaguesViewModel()
    private let services = Services()
    var leaguescollectionView: UICollectionView!
    
    private let searchLeaguesController: UISearchController = {
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
        configureLeaguesCollectionView()
        navigationItem.searchController = searchLeaguesController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.tintColor = .label
        searchLeaguesController.searchResultsUpdater = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.leaguescollectionView.reloadData()
        }
    }
    
    func configureLeaguesCollectionView() {
        leaguescollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout())
        leaguescollectionView.dataSource = self
        leaguescollectionView.delegate = self
        leaguescollectionView.register(LeaguesCollectionViewCell.self, forCellWithReuseIdentifier: LeaguesCollectionViewCell.reuseID)
        view.addSubview(leaguescollectionView)
        view.backgroundColor = .systemBackground
    }
    
    func navigationToDetailsLeagues(leagueDetails: [LeagueStanding]) {
        DispatchQueue.main.async {
            guard !leagueDetails.isEmpty else {
                MakeAlertHelper.alertMassage(title: "League Detail Not Found", message: "Continue For Other Leagues", style: .alert, vc: self)
                return
            }
            let detailsLeague = LeaguesDetailsViewController(selectedLeague: leagueDetails)
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
        cell.leagueSetCell(league: viewModel.leagues[indexPath.item])
        
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
            print("updateSearchResults query Error")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.services.searchLeagues(with: query) { [weak resultController] results in
                DispatchQueue.main.async {
                    guard let searchResults = results else {
                       print("updateSearchResults services Error" )
                        return
                    }
                    resultController?.searchLeagues = searchResults
                    resultController?.searchResultCollectionView.reloadData()
                }
            }
        }
    }
}
