
import Foundation

class Services {
    
    func downloadLeagues(completion: @escaping ([ResponseLeague]?) -> ()) {
        let headers = APIurls.APIKey()
        guard let url = URL(string: APIurls.leagues()) else {
            print("Football API URL Error")
            completion(nil)
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                completion(self.handleWithLeagues(data))
            case .failure(let error):
                print("Failed to download leagues data")
                self.handleWithError(error)
            }
        }
    }
    
    func handleWithLeagues(_ data: Data) -> [ResponseLeague]? {
        do {
            let leagues = try JSONDecoder().decode(LeaguesAPI.self, from: data)
            return leagues.response
        } catch {
            print("Error decoding leagues data: \(error)")
            return nil
        }
    }
    
    func downloadLeaguesDetails(id: Int, completion: @escaping ([LeagueStanding]?) -> ()) {
        let headers = APIurls.APIKey()
        guard let url = URL(string: APIurls.leagueDetailTeams(id: id)) else {
            print("Leagues Teams downloadLeaguesTeams Error")
            completion(nil)
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] leagueTeams in
            guard let self = self else {return}
            switch leagueTeams {
            case .success(let data):
                completion(self.hanfleWithDownloadLeaguesDetails(data))
            case .failure(let error):
                print("Failed to download downloadLeaguesTeams \(error)")
            }
        }
    }
    
    func hanfleWithDownloadLeaguesDetails(_ data: Data) -> [LeagueStanding]? {
        do {
            let leagueTeams = try JSONDecoder().decode(LeaguesDetailsAPI.self, from: data)
            return leagueTeams.response
        } catch {
            print("handleWithDownloadLeaguesTeams Error: \(error)")
            return nil
        }
    }
    

    func searchLeagues(with query: String,completion: @escaping ([ResponseLeague]?) -> ()) {
        let headers = APIurls.APIKey()
        guard let url = URL(string: APIurls.searchLeague(with: query)) else {
            print("Football API URL Error")
            completion(nil)
            return
        }
        NetworkManager.shared.download(url: url, headers: headers) { [weak self] leagues in
            guard let self = self else { return }
            switch leagues {
            case .success(let data):
                completion(self.handleWithSearchLeagues(data))
            case .failure(let error):
                print("Failed to download leagues data")
                self.handleWithError(error)
            }
        }
    }
    
    func handleWithSearchLeagues(_ data: Data) -> [ResponseLeague]? {
        do {
            let leagues = try JSONDecoder().decode(LeaguesAPI.self, from: data)
            return leagues.response
        } catch {
            print("Error decoding leagues data: \(error)")
            return nil
        }
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}



