//
//  Teams.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//

struct TeamsAPI: Codable {
    let get: String?
    let parameters: StandingsParameters?
    let errors: [String]?
    let results: Int?
    let paging: PagingInfo?
    let response: [LeagueStanding]?
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
    let standings: [TeamStanding]?
}

struct LeagueInfo: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
}

struct TeamStanding: Codable {
    let rank: Int?
    let team: TeamInfo?
    let points: Int?
    let goalsDiff: Int?
    let group: String?
    let form: String?
    let status: String?
    let description: String? // Opsiyonel olarak yapıldı
    let all: StandingDetail?
    let home: StandingDetail?
    let away: StandingDetail?
    let update: String?
}

struct TeamInfo: Codable {
    let id: Int?
    let name: String?
    let logo: String?
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



/*
import Foundation

struct Team: Codable {
    var get: String?
    var parameters: [Parameters]?
    var error: [JSONAny]?
    var response: [ResponseTeam]?
}

struct ResponseTeam: Codable {
    var team: TeamDetail?
    var venue:Venue?
}

struct TeamDetail: Codable {
    var id: Int?
    var name: String?
    var country: String?
    var founded: Int?
    var national: Bool?
    var logo: String?
}
struct Venue:Codable{
    var id: Int?
    var name: String?
    var address: String?
    var city: String?
    var capacity: Int?
    var surface: String?
    var image: String?
}
*/



 
