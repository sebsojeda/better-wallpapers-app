//
//  Fetcher.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/25/23.
//

import Foundation

class Fetcher {
    enum FetchError: Error {
        case badRequest, badJSON, badURL
    }
    
    func fetch<T: Decodable>(_ T: T.Type, endpoint: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(nil, FetchError.badURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, FetchError.badRequest)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, FetchError.badRequest)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T, from: data!)
                completion(decoded, nil)
            } catch {
                completion(nil, FetchError.badJSON)
            }
        }
        
        task.resume()
    }
}
