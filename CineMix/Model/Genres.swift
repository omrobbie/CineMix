//
//  Genres.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Genres: Decodable {

    let genres: [Genre]
}

struct Genre: Decodable {

    let id: Int?
    let name: String?
}
