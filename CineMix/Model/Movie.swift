//
//  Movie.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Movie: Decodable {

    let page: Int?
    let total_pages: Int?
    let results: [MovieResult]?
}

struct MovieResult: Decodable {

    let id: Int?
    let title: String?
    let vote_average: Float?
    let poster_path: String?
    let backdrop_path: String?
}
