//
//  API.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 30.03.2024.
//

import Foundation


enum APIUrls {
    static func APIKey() -> [String: String] {
        return [
            "X-RapidAPI-Key": "09b7c2901dmsh6d62a75afce8803p185e35jsn86cc90bb97fe",
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
        ]
    }
    static func urlAllLeagues() -> String {
        return "https://api-football-v1.p.rapidapi.com/leagues/season/2023"
    }
    
    static func leagueDetails (id: Int) -> String {
        return "https://api-football-v1.p.rapidapi.com/v3/leagues?id=\(id)"
    }
    
    static func images(id: Int) -> String {
        return "https://media.api-sports.io/football/leagues/\(id).png"
    }
}
