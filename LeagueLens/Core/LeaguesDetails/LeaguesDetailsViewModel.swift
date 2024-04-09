import Foundation

protocol LeaguesDetailsViewModelInterface {
    var view: LeaguesDetailsViewControllerInterface? { get set }
    func viewDidLoad()
}

final class LeaguesDetailsViewModel: LeaguesDetailsViewModelInterface {
    var leagueViewModel: LeagueStanding?
    weak var view: LeaguesDetailsViewControllerInterface?

    func viewDidLoad() {
        view?.configureLeaguesDetailsViewController()
        view?.leaguesDetailsHeaderView()
        view?.configureLeaguesDetailsCollectionView()
        view?.reloadData()
    }
    
    }

