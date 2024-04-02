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
}

extension LeaguesViewModel: LeaguesViewModelInterface {
    func viewDidLoad() {
        view?.configureCollectionView()
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
            self.view?.reloadData()
            self.leagues.append(contentsOf: returnedLeagues)
        }
    }
    
   func getLeaguesDetail(id: Int) {
       services.downloadLeagueDetail(id: id) { [weak self] returnDetails in
           guard let self = self else {
               print("getLeaguesDetail self Error")
               return
           }
           guard let returnDetails = returnDetails else {
               print("getLeaguesDetail returnDetails Error")
               return
           }
           self.view?.navigationToDetailsLeague(league: returnDetails)
           print("getLeaguesDetail' dan dönen veri \(returnDetails.league?.id)")

       }
   }
    
   
}



