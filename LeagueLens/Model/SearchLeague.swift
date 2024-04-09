//
//  SearchLeague.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 9.04.2024.
//

import Foundation


struct SearchLeagueAPIResponse: Codable {
    let get: String
    let parameters: SearchParameters
    let errors: [String]
    let results: Int
    let paging: Paging
    let response: [SearchLeagueResponse]
}

struct SearchParameters: Codable {
    let search: String
}

struct Paging: Codable {
    let current: Int
    let total: Int
}

struct SearchLeagueResponse: Codable {
    let league: SearchLeague
    let country: SearchCountry
    let seasons: [Season]
}

struct SearchLeague: Codable {
    let id: Int
    let name: String
    let type: String
    let logo: String
}

struct SearchCountry: Codable {
    let name: String
    let code: String
    let flag: String
}

struct Season: Codable {
    let year: Int
    let start: String
    let end: String
    let current: Bool
    let coverage: Coverage
}

struct Coverage: Codable {
    let fixtures: Fixtures
    let standings: Bool
    let players: Bool
    let top_scorers: Bool
    let top_assists: Bool
    let top_cards: Bool
    let injuries: Bool
    let predictions: Bool
    let odds: Bool
}

struct Fixtures: Codable {
    let events: Bool
    let lineups: Bool
    let statistics_fixtures: Bool
    let statistics_players: Bool
}
