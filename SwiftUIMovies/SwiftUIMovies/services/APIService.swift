//
//  APIService.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

struct APIService {
    let baseURL = URL(string: "https://api.themoviedb.org/3")!
    let apiKey = "adicione sua api aqui"
    static let shared = APIService()
    let decoder = JSONDecoder()
    
    enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    
    enum Endpoint {
        case popular, toRated, upcoming, nowPlaying
        case detail(movie: Int), recommended(movie: Int), similar(movie: Int)
        case credits(movie: Int), review(movie: Int)
        case searchMovie, searchKeyword
        case genres
        case discover
        
        func path() -> String {
            switch self {
            case .popular:
                return "movie/popular"
            case .toRated:
                return "movie/top_rated"
            case .upcoming:
                return "movie/upcoming"
            case .nowPlaying:
                return "movie/now_playing"
            case let .detail(movie):
                return "movie/\(String(movie))"
            case let .credits(movie):
                return "movie/\(String(movie))/credits"
            case let .review(movie):
                return "movie/\(String(movie))/reviews"
            case let .recommended(movie):
                return "movie/\(String(movie))/recommendations"
            case let .similar(movie):
                return "movie/\(String(movie))/similar"
            case .searchMovie:
                return "search/movie"
            case .searchKeyword:
                return "search/keyword"
            case .genres:
                return "genre/movie/list"
            case .discover:
                return "discover/movie"
            }
        }
    }
    
    func GET<T: Codable>(endpoint: Endpoint,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
        ]
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
    
}

