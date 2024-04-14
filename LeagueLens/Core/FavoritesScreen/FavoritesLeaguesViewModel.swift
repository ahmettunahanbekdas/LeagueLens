
import Foundation
import UIKit

protocol FavoritesViewModelInterface {
    var view: FavoritesLeaguesViewControllerInterface? { get set }
    func deleteFavoritesLeague()
}

final class FavoritesLeaguesViewModel {
    var view: FavoritesLeaguesViewControllerInterface?
    var favoritesLeagues: [TitleItem] = [TitleItem]()
    var deleteFavoritesItem: TitleItem?
    private let services = Services()
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    func viewWillAppear() {
        view?.configureFavoritesLeaguesView()
        fetchLocalStorageForFavorites()
        print("viewWillAppear")
    }
    
    private func fetchLocalStorageForFavorites() {
        DataPersistenceManager.shared.fetchingFavoritesLeaguesFromDataBase { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.favoritesLeagues = leagues
                self?.view?.reloadData()
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func deleteFavoritesLeague() {
        guard let model = deleteFavoritesItem else {
            print("deleteFavoritesLeague model Error")
            return
        }
        DataPersistenceManager.shared.deleteFavoritesLeaguFromDatabase(model: model) { [weak self] result in
            guard let self = self else {
                print("deleteFavoritesLeague self Error")
                return
            }
            switch result {
            case .success():
                if let selectedIndex = self.favoritesLeagues.firstIndex(where: { $0.id == model.id }) {
                    self.favoritesLeagues.remove(at: selectedIndex)
                    DispatchQueue.main.async {
                        self.view?.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    MakeAlertHelper.alertMassage(title: "League Deleted", message: " ", style: .actionSheet, vc: (self.view as? UIViewController)!)
                }
            case .failure(_):
                print("delete failure")
                DispatchQueue.main.async {
                    MakeAlertHelper.alertMassage(title: "League Not Deleted", message: " ", style: .actionSheet, vc: (self.view as? UIViewController)!)
                }
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
            self.view?.navigationFavoritesToDetailsLeagues(leagueDetails: returnFavoritesLeague)
        }
    }
}
