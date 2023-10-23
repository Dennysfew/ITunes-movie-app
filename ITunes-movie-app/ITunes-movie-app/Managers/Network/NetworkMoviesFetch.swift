//
//  NetworkMoviesFetch.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchMovie(urlString: String, response: @escaping (MovieResult?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(MovieResult.self, from: data)
                    response(movies, nil)
                } catch let jsonError {
                    print("Failed to decode JSON: \(jsonError.localizedDescription)")
                    response(nil, jsonError)
                }
            case .failure(let error):
                print("Error receiving data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}
