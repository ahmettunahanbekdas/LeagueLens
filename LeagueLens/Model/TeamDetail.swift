//
//  TeamDetail.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 7.04.2024.
//

import Foundation

struct TeamDetailAPI: Codable {
    let team: Team
    let venue: Venue
}

struct Team: Codable {
    let id: Int
    let name: String
    let code: String
    let country: String
    let founded: Int
    let national: Bool
    let logo: String
}

struct Venue: Codable {
    let id: Int
    let name: String
    let address: String
    let city: String
    let capacity: Int
    let surface: String
    let image: String
}
