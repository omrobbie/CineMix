//
//  ApiService.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct ApiService {

    static let shared = ApiService()

    internal let apiKey: String = {
        return Config.apiKey ?? ""
    }()

    internal let BASE_URL = "https://api.themoviedb.org/3"
    internal let IMAGE_URL = "https://image.tmdb.org/t/p/"
    internal let VIDEO_URL = "https://img.youtube.com/vi/"

    internal let MOVIE = "/movie"
    internal let CREDITS = "/credits"
    internal let PERSON = "/person"
    internal let DISCOVER = "/discover"
    internal let GENRE = "/genre"
    internal let LIST = "/list"
    internal let REVIEW = "/review"

    internal let NOW_PLAYING = "/now_playing"
    internal let VIDEOS = "/videos"
    internal let REVIEWS = "/reviews"
    internal let UPCOMING = "/upcoming"
    internal let TOP_RATED = "/top_rated"
    internal let POPULAR = "/popular"
}

// MARK: - Download image
extension ApiService {

    enum ImageSize: String {
        case tiny = "w45"
        case small = "w92"
        case large = "w500"
        case original = "original"
    }

    func downloadImage(path: String, size: ImageSize = .large, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: IMAGE_URL + size.rawValue + path) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }

    func downloadVideoThumbnail(path: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: VIDEO_URL + path + "/0.jpg") else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
}
