//
//  ReviewsService.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension ApiService {

    func getReviews(page: Int = 1, movieId: Int, completion: @escaping (Reviews) -> ()) {
        guard var urlComponents = URLComponents(string: BASE_URL + MOVIE + "/\(movieId)" + REVIEWS) else {return}

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
                let json = try JSONDecoder().decode(Reviews.self, from: data)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }

    func getReviewsDetail(reviewId: String, completion: @escaping (ReviewsDetail) -> ()) {
        guard var urlComponents = URLComponents(string: BASE_URL + REVIEW + "/\(reviewId)") else {return}

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = urlComponents.url else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {return}

            do {
                let json = try JSONDecoder().decode(ReviewsDetail.self, from: data)
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
