
import Foundation

protocol FavoritesViewModelInterface {
    var view: FavoritesLeaguesViewControllerInterface? { get set }
}

final class FavoritesLeaguesViewModel {
    var view: FavoritesLeaguesViewControllerInterface?
    var favoritesLeagues: [TitleItem] = [TitleItem]()
    private let services = Services()
    
    func viewDidLoad() {
        view?.configureFavoritesLeaguesView()
        fetchLocalStorageForFavorites()
    }
    
    func viewWillAppear() {
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    private func fetchLocalStorageForFavorites() {
        DataPersistenceManager.shared.fetchingFavoritesLeaguesFromDataBase { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.favoritesLeagues = leagues
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func didSelectedFavoritesLeagueDeatil(id: Int) {
        services.downloadLeaguesDetails(id: id) { [weak self] returned in
            guard let self = self else {
                print("didSelectedFavoritesLeagueDeatil self Error")
                return
            }
            guard let returnFavoritesLeague = returned else {
                print("didSelectedFavoritesLeagueDeatil returned Error")
                return
            }
            self.view?.navigationDetailsLeagues(leagueDetails: returnFavoritesLeague)
        }
    }
}
