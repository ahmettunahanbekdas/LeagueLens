
import Foundation


protocol SearchResultViewModelInterface {
    var view: SearchResultViewControllerInterface? { get set }
}

final class SearchResultViewModel {
    weak var view: SearchResultViewControllerInterface?
    var searchLeagues: [ResponseLeague] = []

}

extension SearchResultViewModel: SearchResultViewModelInterface {
    func viewDidLoad() {
        view?.configureResultCollectionView()
    }
}
