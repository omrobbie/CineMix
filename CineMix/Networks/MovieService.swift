//
//  MovieService.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension ApiService {

    func getMovieList(page: Int = 1, type: MovieType, completion: @escaping (Movie) -> ()) {
        var urlString = BASE_URL + MOVIE

        switch type {
        case .nowPlaying: urlString += NOW_PLAYING
        case .upComing: urlString += UPCOMING
        case .topRated: urlString += TOP_RATED
        case .popular: urlString += POPULAR
        default: break
        }

        guard var urlComponents = URLComponents(string: urlString) else {return}

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = urlComponents.url else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
