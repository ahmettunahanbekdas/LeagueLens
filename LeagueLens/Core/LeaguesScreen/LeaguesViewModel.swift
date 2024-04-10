
import Foundation

protocol LeaguesViewModelInterface {
    var view: LeaguesViewControllerInterface? {get set}
    func viewDidLoad()
    func getLeagues()
    func didSelectedLeaguesDetail(id: Int)
}

final class LeaguesViewModel {
    weak var view: LeaguesViewControllerInterface?
    private let services = Services()
    var leagues: [ResponseLeague] = []
}

extension LeaguesViewModel: LeaguesViewModelInterface {
    func viewDidLoad() {
        view?.configureLeaguesView()
        getLeagues()
    }
    
    func getLeagues() {
        services.downloadLeagues { [weak self] returnedLeagues in
            guard let self = self else {
                print("Error")
                return
            }
            guard let returnedLeagues = returnedLeagues else {
                print("returnedLeagues")
                return
            }
            self.leagues.append(contentsOf: returnedLeagues)
            self.view?.reloadData()
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
             self.view?.navigationToDetailsLeagues(leagueDetails: returnedLeagueDetail)
        }
    }
}



