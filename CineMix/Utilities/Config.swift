//
//  Config.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Config {

    static let apiKey: String? = {
        return getValue(of: "ApiKey") as? String
    }()

    static func getValue(of key: String) -> Any? {
        var keys: NSDictionary?

        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }

        return keys?[key]
    }
}
