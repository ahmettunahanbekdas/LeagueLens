
import Foundation

struct LeaguesDetailsAPI: Codable {
    let get: String?
    let parameters: StandingsParameters?
    let errors: [String]?
    let results: Int?
    let paging: PagingInfo?
    let response: [LeagueStanding]?
    
    enum CodingKeys: String, CodingKey {
           case get = "get"
           case parameters, errors, results, paging, response
       }
}

struct StandingsParameters: Codable {
    let league: String?
    let season: String?
}

struct PagingInfo: Codable {
    let current: Int?
    let total: Int?
}

struct LeagueStanding: Codable {
    let league: LeagueInfo?
}

struct LeagueInfo: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let standings: [[TeamStanding]]?
    
    var _id: Int {
        id ?? Int.min
    }
}

struct TeamStanding: Codable {
    let rank: Int?
    let team: TeamInfo?
    let points: Int?
    let goalsDiff: Int?
    let group: String?
    let form: String?
    let status: String?
    let description: String?
    let all: StandingDetail?
    let home: StandingDetail?
    let away: StandingDetail?
    let update: String?
}

struct TeamInfo: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    
    var _id: Int {
        id ?? Int.min
    }
}

struct StandingDetail: Codable {
    let played: Int?
    let win: Int?
    let draw: Int?
    let lose: Int?
    let goals: GoalInfo?
}

struct GoalInfo: Codable {
    let `for`: Int?
    let against: Int?
}


 
