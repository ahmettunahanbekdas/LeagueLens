// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct LeaguesAPI: Codable {
    var get: String?
    var parameters: [Parameters]?
    var response: [ResponseLeague]?

    enum CodingKeys: String, CodingKey {
        case get = "get"
        case parameters , response
    }
}

struct Parameters: Codable {
    var id: String?
}

struct ResponseLeague: Codable {
    var league: League?
    var country: Country?
}

struct Country: Codable {
    var name: String?
    var code: String?
    var flag: URL?
}

struct League: Codable {
    var id: Int?
    var name, type: String?
    var logo: String?
}



/*
// MARK: - Welcome
struct LeaguesAPI: Codable {
    var get: String?
    var parameters: [Parameters]?
    var errors: [JSONAny]?
    var results: Int?
    var paging: Paging?
    var response: [ResponseLeague]?

    enum CodingKeys: String, CodingKey {
        case get = "get"
        case parameters , errors, results, paging, response
    }
}

// MARK: - Paging
struct Paging: Codable {
    var current, total: Int?
}



// MARK: - Response
struct ResponseLeague: Codable {
    var league: League?
    var country: Country?
    var seasons: [Season]?
}

// MARK: - Country

// MARK: - League


// MARK: - Season
struct Season: Codable {
    var year: Int?
    var start, end: String?
    var current: Bool?
    var coverage: Coverage?
}

// MARK: - Coverage
struct Coverage: Codable {
    var fixtures: Fixtures?
    var standings, players, topScorers, topAssists: Bool?
    var topCards, injuries, predictions, odds: Bool?

    enum CodingKeys: String, CodingKey {
        case fixtures, standings, players
        case topScorers = "top_scorers"
        case topAssists = "top_assists"
        case topCards = "top_cards"
        case injuries, predictions, odds
    }
}

// MARK: - Fixtures
struct Fixtures: Codable {
    var events, lineups, statisticsFixtures, statisticsPlayers: Bool?

    enum CodingKeys: String, CodingKey {
        case events, lineups
        case statisticsFixtures = "statistics_fixtures"
        case statisticsPlayers = "statistics_players"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue:Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
*/


