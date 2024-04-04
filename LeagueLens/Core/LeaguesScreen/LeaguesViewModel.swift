//
//  LeaguesViewModel.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//


import Foundation

protocol LeaguesViewModelInterface {
    var view: LeaguesViewControllerInterface? {get set}
    func viewDidLoad()
    func getLeagues()
}

final class LeaguesViewModel {
    weak var view: LeaguesViewControllerInterface?
    
    private let services = Services()
    var leagues: [ResponseLeague] = []
    //var selectedLeague: ResponseLeague?
}

extension LeaguesViewModel: LeaguesViewModelInterface {
    func viewDidLoad() {
        view?.configureLeaguesView()
        getLeagues()
    }

    func getLeagues() {
        services.downloadLeagues { [weak self] returnedLeagues in
            guard let self = self else {
                print("Error")
                return
            }
            guard let returnedLeagues = returnedLeagues else {
                print("returnedLeagues")
                return
            }
            self.leagues.append(contentsOf: returnedLeagues)
            self.view?.reloadData()
        }
    }
    
    func leagueDidSelected(at index: IndexPath) {
        let leagueSelectedItem = leagues[index.item] 
        view?.navigationToDetailsLeague(league: leagueSelectedItem)
    }
    
 
   
   
}



