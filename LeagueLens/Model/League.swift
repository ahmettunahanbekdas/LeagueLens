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
