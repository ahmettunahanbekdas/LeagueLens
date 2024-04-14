
import Foundation

struct LeaguesAPI: Codable {
    var get: String?
    //var parameters: [Parameters]?
    var response: [ResponseLeague]?

    enum CodingKeys: String, CodingKey {
        case get = "get"
        //case parameters , response
        case response
    }
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
    
    var _id: Int {
        id ?? Int.min
    }
}
