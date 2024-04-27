
import Foundation


protocol SearchResultViewModelInterface {
    var delegate: SearchResultViewControllerDelegate? {get set}
}

final class SearchResultViewModel {
    weak var delegate: SearchResultViewControllerDelegate?
    var searchLeagues: [ResponseLeague] = []
    var services = Services()
}

extension SearchResultViewModel: SearchResultViewModelInterface {
    func viewDidLoad() {
        delegate?.configureResultCollectionView()
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
            self.delegate?.navigationSearchToDetailsLeagues(leagueDetails: result)
        }
    }
}
