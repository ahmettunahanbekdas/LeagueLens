import UIKit

protocol FavoritesViewControllerInterface: AnyObject {
    func configureView()
    func reloadData()
}

class FavoritesViewController: UIViewController {
    private let viewModel = FavoritesViewModel()
    
    
    let favoritesTableView: UITableView = {
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
            self.favoritesTableView.reloadData()
        }
    }
}

extension FavoritesViewController: FavoritesViewControllerInterface {
    func configureView() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        view.addSubview(favoritesTableView)
        favoritesTableView.frame = view.bounds
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        let titleItem = viewModel.leagues[indexPath.row]
        cell.setCell(titleItem: titleItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteLeagueWith(model: viewModel.leagues[indexPath.row]) { [weak self] results in
                guard let self = self else {
                    print("delete self Error")
                    return
                }
                switch results {
                case .success():
                    MakeAlert.alertMassage(title: "League Deleted", message: "Okay", style: .actionSheet, vc: self)
                case.failure(_):
                    MakeAlert.alertMassage(title: "League Not Deleted", message: "Okay", style: .actionSheet, vc: self)
                }
                viewModel.leagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default :
            break;
        }
    }
}


