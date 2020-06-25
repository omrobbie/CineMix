//
//  Videos.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Videos: Decodable {

    let results: [VideosResults]?
}

struct VideosResults: Decodable {

    let key: String?
    let name: String?
    let site: String?
    let type: String?
}
