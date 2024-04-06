//
//  LeaguesDetailsViewModel.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//

import Foundation

protocol LeaguesDetailsViewModelInterface {
    var view: LeaguesDetailsViewControllerInterface? {get set}
}

final class LeaguesDetailsViewModel{
   weak var view: LeaguesDetailsViewControllerInterface?
    private let services = Services()
    var teams: [LeagueStanding] = []
}

extension LeaguesDetailsViewModel: LeaguesDetailsViewModelInterface {
    func viewDidLoad() {
        view?.headerView()
        view?.configureCollectionView()
        view?.reloadData()
    }
}

