
import Foundation

enum Endpoint {
    static func APIKey() -> [String: String] {
        return [
            "X-RapidAPI-Key": "09b7c2901dmsh6d62a75afce8803p185e35jsn86cc90bb97fe",
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
        ]
    }
    
    static func leagues() -> String {
        return "https://api-football-v1.p.rapidapi.com/v3/leagues"
    }
        
    static func leaguesPosterImageView(id: Int) -> String {
        return "https://media.api-sports.io/football/leagues/\(id).png"
    }
    
    static func leagueDetailTeams(id: Int) -> String {
        return "https://api-football-v1.p.rapidapi.com/v3/standings?season=2023&league=\(id)"
    }
    
    static func teamsPosterImageView(id: Int) -> String {
        return "https://media.api-sports.io/football/teams/\(id).png"
    }
    
    static func teamsDetails(id: Int) -> String {
        return "https://api-football-v1.p.rapidapi.com/v3/teams?id=\(id)"
    }
    
    static func searchLeague(with query: String) -> String {
        return "https://api-football-v1.p.rapidapi.com/v3/leagues?search=\(query)"
    }
}
