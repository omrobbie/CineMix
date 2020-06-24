//
//  NowPlayingService.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension ApiService {

    func getNowPlaying(page: Int = 1, completion: @escaping (Movie) -> ()) {
        guard var urlComponents = URLComponents(string: BASE_URL + NOW_PLAYING) else {return}

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
