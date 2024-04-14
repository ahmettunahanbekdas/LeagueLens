
import Foundation


protocol SearchResultViewModelInterface {
    var view: SearchResultViewControllerInterface? { get set }
}

final class SearchResultViewModel {
    weak var view: SearchResultViewControllerInterface?
    var searchLeagues: [ResponseLeague] = []
    var services = Services()
}

extension SearchResultViewModel: SearchResultViewModelInterface {
    func viewDidLoad() {
        view?.configureResultCollectionView()
    }
    
    
    func didSelectedSearchLeagues(id: Int) {
        services.downloadLeaguesDetails(id: id) { [weak self] result in
            guard let self = self else {
                print("didSelectedSearchLeagues self Error")
                return
            }
            guard let result = result else {
                print("didSelectedSearchLeagues result Error")
                return
            }
            self.view?.navigationSearchToDetailsLeagues(leagueDetails: result)
            print("test")
        }
    }
}
