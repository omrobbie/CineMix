//
//  Reviews.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Reviews: Decodable {

    let page: Int
    let total_pages: Int
    let results: [ReviewsResults]?
}

struct ReviewsResults: Decodable {

    let id: String?
    let author: String?
    let content: String?
}
