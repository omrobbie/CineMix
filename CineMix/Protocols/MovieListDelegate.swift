//
//  MovieListDelegate.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

enum MovieType {
    case nowPlaying
    case upComing
    case topRated
    case popular
}

protocol MovieListDelegate {

    func seeAllMovies(type: MovieType)
    func movieDetail(item: MovieResult)
}
