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

    internal let BASE_URL = "https://api.themoviedb.org/3/movie/"
    internal let NOW_PLAYING = "now_playing"
}
