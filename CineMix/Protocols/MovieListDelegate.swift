//
//  MovieListDelegate.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

enum MovieType: String {
    case nowPlaying = "Now Playing"
    case upComing = "Upcoming"
    case topRated = "Top Rated"
    case popular = "Popular"
    case genre = "Genre: "
}

protocol MovieListDelegate {

    func seeAllMovies(type: MovieType)
    func movieDetail(item: MovieResult)
}
