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
    
    func downloadLeagueDetail(id: Int, completion: @escaping (ResponseLeague?) -> ()) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.leagueDetails(id: id)) else {
            print("TeamDetail Error")
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] leagueDetail in
            guard let self = self else {return}
            switch leagueDetail {
            case.success(let data):
                completion(self.handleWithLeaguDetail(data))
               print("downloadLeagueDetail' dan dönen data boş mu \(data)")
               print("downloadLeagueDetail\(url)")
                print(data.base64EncodedString())
            case .failure(let error):
                print("HATA!")
                self.handleWithError(error)
            }
        }
    }
    
    func handleWithLeague(_ data: Data) -> [ResponseLeague]? {
        do {
            let leagues = try JSONDecoder().decode(Leaguess.self, from: data)
            //print("\(leagues.response?.isEmpty)")
            return leagues.response
        } catch {
            print("Error decoding leagues data: \(error)")
            return nil
        }
    }
 
    
   
    
    // Problem burada
    func handleWithLeaguDetail(_ data: Data) -> (ResponseLeague)? {
        do {
            let leagueDetail = try JSONDecoder().decode(ResponseLeague.self, from: data)
            return leagueDetail.self  
        }catch {
            print("Error decoding leagues data: \(error)")
            return nil
        }
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}



