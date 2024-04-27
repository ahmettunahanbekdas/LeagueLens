
import Foundation

protocol LeaguesDetailsViewModelDelegate {
    var delegate: LeaguesDetailsViewControllerDelegate? {get set}
    func viewDidLoad()
}

final class LeaguesDetailsViewModel: LeaguesDetailsViewModelDelegate {
    var leagueViewModel: LeagueStanding?
    weak var delegate: LeaguesDetailsViewControllerDelegate?
    
    func viewDidLoad() {
        delegate?.configureLeaguesDetailsViewController()
        delegate?.leaguesDetailsHeaderView()
        delegate?.configureLeaguesDetailsCollectionView()
        delegate?.reloadData()
    }
}

