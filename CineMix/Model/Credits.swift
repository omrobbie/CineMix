//
//  Credits.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Credits: Decodable {

    let cast: [Cast]?
}

struct Cast: Decodable {

    let id: Int?
    let name: String?
    let character: String?
    let profile_path: String?
}
