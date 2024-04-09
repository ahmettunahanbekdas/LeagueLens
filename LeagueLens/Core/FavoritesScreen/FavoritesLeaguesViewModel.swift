
import Foundation

protocol FavoritesViewModelInterface {
    var view: FavoritesLeaguesViewControllerInterface? { get set }
}

final class FavoritesLeaguesViewModel {
    var view: FavoritesLeaguesViewControllerInterface?
     var favoritesLeagues: [TitleItem] = [TitleItem]()

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
}
