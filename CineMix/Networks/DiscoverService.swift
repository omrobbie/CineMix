//
//  DiscoverService.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension ApiService {

    func getDiscover(page: Int = 1, genres: String?, people: String?, completion: @escaping (Movie) -> ()) {
        guard var urlComponents = URLComponents(string: BASE_URL + DISCOVER + MOVIE) else {return}

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        if let genres = genres {
            urlComponents.queryItems?.append(URLQueryItem(name: "with_genres", value: genres))
        }

        if let people = people {
            urlComponents.queryItems?.append(URLQueryItem(name: "with_people", value: people))
        }

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
