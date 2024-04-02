//
//  Teams.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//


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




 
