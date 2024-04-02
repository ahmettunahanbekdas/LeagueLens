//
//  NetworkManager.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 30.03.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    @discardableResult

    func download(url: URL, headers: [String: String], completion: @escaping(Result<Data, Error>) -> ()) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            guard
                let data = data else {
                completion(.failure(URLError(.badURL)))
                return
            }
            completion(.success(data))

        }
        dataTask.resume()
        
        return dataTask
    }
}




