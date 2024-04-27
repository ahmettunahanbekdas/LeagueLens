
import Foundation

protocol LeaguesViewModelDelegate {
    var delegate: LeaguesViewControllerDelegate? {get set}
    func viewDidLoad()
    func getLeagues()
    func didSelectedLeaguesDetail(id: Int)
}

final class LeaguesViewModel {
    weak var delegate: LeaguesViewControllerDelegate?
    private let services = Services()
    var leagues: [ResponseLeague] = []
}

extension LeaguesViewModel: LeaguesViewModelDelegate {
    func viewDidLoad() {
        delegate?.configureLeaguesCollectionView()
        delegate?.configureLeaguesView()
        getLeagues()
    }
    
    func getLeagues() {
        services.downloadLeagues { [weak self] returnedLeagues in
            guard let self = self else {
                print("getLeagues self Error")
                return
            }
            guard let returnedLeagues = returnedLeagues else {
                print("returnedLeagues")
                return
            }
            self.leagues.append(contentsOf: returnedLeagues)
            self.delegate?.reloadData()
        }
    }
    
    func didSelectedLeaguesDetail(id: Int) {
        services.downloadLeaguesDetails(id: id) { [weak self] returnedLeagueDetail in
            guard let self = self else {
                print("didSelectedLeaguesDetail self Error")
                return
            }
            guard let returnedLeagueDetail = returnedLeagueDetail else {
                print("Failed to download league detail")
                return
            }
             self.delegate?.navigationToDetailsLeagues(leagueDetails: returnedLeagueDetail)
        }
    }
}
