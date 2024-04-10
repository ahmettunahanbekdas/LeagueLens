
import UIKit

protocol FavoritesLeaguesViewControllerInterface: AnyObject {
    func configureFavoritesLeaguesView()
    func reloadData()
    func navigationDetailsLeagues(leagueDetails: [LeagueStanding]) 

}

class FavoritesLeaguesViewController: UIViewController {
    private let viewModel = FavoritesLeaguesViewModel()
    
    
    let favoritesLeaguesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.view = self
        viewModel.viewWillAppear()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.favoritesLeaguesTableView.reloadData()
        }
    }
}

extension FavoritesLeaguesViewController: FavoritesLeaguesViewControllerInterface {
    func configureFavoritesLeaguesView() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        view.addSubview(favoritesLeaguesTableView)
        favoritesLeaguesTableView.frame = view.bounds
        favoritesLeaguesTableView.delegate = self
        favoritesLeaguesTableView.dataSource = self
    }
    
    func navigationDetailsLeagues(leagueDetails: [LeagueStanding]) {
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

extension FavoritesLeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritesLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        let leaguesItems = viewModel.favoritesLeagues[indexPath.row]
        cell.favoritesLeaguesSetCell(leaguesItem: leaguesItems)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteFavoritesLeaguFromDatabase(model: viewModel.favoritesLeagues[indexPath.row]) { [weak self] results in
                guard let self = self else {
                    print("delete self Error")
                    return
                }
                switch results {
                case .success():
                    MakeAlertHelper.alertMassage(title: "League Deleted", message: " ", style: .actionSheet, vc: self)
                case.failure(_):
                    MakeAlertHelper.alertMassage(title: "League Not Deleted", message: " ", style: .actionSheet, vc: self)
                }
                viewModel.favoritesLeagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default :
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectedFavoritesLeagueDeatil(id: Int(viewModel.favoritesLeagues[indexPath.row].id))
    }
}
