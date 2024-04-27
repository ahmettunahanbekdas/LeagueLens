
import UIKit

protocol LeaguesViewControllerDelegate: AnyObject {
    func configureLeaguesCollectionView()
    func configureLeaguesView()
    func reloadData()
    func navigationToDetailsLeagues(leagueDetails: [LeagueStanding])
}

final class LeaguesViewController: UIViewController {
    lazy var viewModel = LeaguesViewModel()
    private let services = Services()
    
    private var leaguescollectionView: UICollectionView!
    private let searchLeaguesController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search League"
        controller.searchBar.searchBarStyle = .prominent
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}

extension LeaguesViewController: LeaguesViewControllerDelegate {
    func configureLeaguesView() {
        title = "League Lens"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
                MakeAlertHelper.alertMassage(action: "Okay", title: "League Detail Not Found", message: "Continue For Other Leagues", style: .alert, vc: self)
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
        cell.vc = self
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
            print("Please enter 3 character")
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
