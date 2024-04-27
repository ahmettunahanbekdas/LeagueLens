
import Foundation
import UIKit

protocol FavoritesViewModelDelegate {
    var view: FavoritesLeaguesViewControllerDelegate? { get set }
    func deleteFavoritesLeague()
}

final class FavoritesLeaguesViewModel {
    var delegate: FavoritesLeaguesViewControllerDelegate?
    var favoritesLeagues: [TitleItem] = [TitleItem]()
    var deleteFavoritesItem: TitleItem?
    private let services = Services()
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    func viewWillAppear() {
        delegate?.configureFavoritesLeaguesView()
        fetchLocalStorageForFavorites()
        print("viewWillAppear")
    }
    
    private func fetchLocalStorageForFavorites() {
        DataPersistenceManager.shared.fetchingFavoritesLeaguesFromDataBase { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.favoritesLeagues = leagues
                self?.delegate?.reloadData()
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
        DispatchQueue.main.async {
            MakeAlertHelper.deleteAlertMassage(action: "Delete", title: "League Deleted", message: "Are you sure you want to delete this league?", style: .alert, vc: (self.delegate as? UIViewController)!) {
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
                                self.delegate?.reloadData()
                            }
                        }
                    case .failure(_):
                        print("delete failure")
                    }
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
            self.delegate?.navigationFavoritesToDetailsLeagues(leagueDetails: returnFavoritesLeague)
        }
    }
}
