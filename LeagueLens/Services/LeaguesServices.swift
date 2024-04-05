//
//  MovieServices.swift
//  MoviesApp
//
//  Created by Ahmet Tunahan Bekdaş on 23.01.2024.
//

//
//  FootballServices.swift
//  FootballApp
//
//  Created by Ahmet Tunahan Bekdaş on 23.01.2024.
//

import Foundation

class Services {
    
    func downloadLeagues(completion: @escaping ([ResponseLeague]?) -> ()) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.urlAllLeagues()) else {
            print("Football API URL Error")
            completion(nil)
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] leagues in
            guard let self = self else { return }
            switch leagues {
            case .success(let data):
                completion(self.handleWithLeague(data))
            case .failure(let error):
                print("Failed to download leagues data")
                self.handleWithError(error)
            }
        }
    }
    
    func handleWithLeague(_ data: Data) -> [ResponseLeague]? {
        do {
            let leagues = try JSONDecoder().decode(LeaguesAPI.self, from: data)
            return leagues.response
        } catch {
            print("Error decoding leagues data: \(error)")
            return nil
        }
    }
    
    func downloadLeaguesTeams(id: Int, completion: @escaping (LeagueStanding?) -> ()) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.LeagueTeams(id: id)) else {
            print("Leagues Teams downloadLeaguesTeams Error")
            completion(nil)
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] leagueTeams in
            guard let self = self else {return}
            switch leagueTeams {
            case .success(let data):
                completion(self.handleWithDownloadLeaguesTeams(data))
            case .failure(let error):
                print("Failed to download downloadLeaguesTeams \(error)")
            }
        }
    }
    
    func handleWithDownloadLeaguesTeams(_ data: Data) -> LeagueStanding? {
        do {
            let leagueTeams = try JSONDecoder().decode(TeamsAPI.self, from: data)
           

            return leagueTeams.response?.first // Lig durumları dizisini döndür

        } catch {
            print("handleWithDownloadLeaguesTeams Error: \(error)")
            return nil
        }
    }
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}



