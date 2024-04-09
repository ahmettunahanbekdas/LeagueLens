import Foundation

protocol FavoritesViewModelInterface {
    var view: FavoritesViewControllerInterface? { get set }
}

final class FavoritesViewModel {
    var view: FavoritesViewControllerInterface?
     var leagues: [TitleItem] = [TitleItem]()

    func viewDidLoad() {
        view?.configureView()
        fetchLocalStorageForFavorites()
    }
    
    func viewWillAppear() {
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }

    private func fetchLocalStorageForFavorites() {
        DataPersistenceManager.shared.fetchingLeaguesFromDataBase { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.leagues = leagues
            case .failure(_):
                print("Error")
            }
        }
    }
}

