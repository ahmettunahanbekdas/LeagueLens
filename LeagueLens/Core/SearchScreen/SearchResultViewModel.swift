//
//  SearchResultViewModel.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 8.04.2024.
//

import Foundation


protocol SearchResultViewModelInterface {
    var view: SearchResultViewControllerInterface? { get set }
}

final class SearchResultViewModel {
    weak var view: SearchResultViewControllerInterface?
    var leagues: [ResponseLeague] = []

}


extension SearchResultViewModel: SearchResultViewModelInterface {
    func viewDidLoad() {
        view?.configureResultCollectionView()
    }
}
