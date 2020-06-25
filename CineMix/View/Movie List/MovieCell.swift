//
//  MovieCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgPosterIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtRelease: UILabel!
    @IBOutlet weak var txtVote: UILabel!
    @IBOutlet weak var txtOverview: UILabel!

    func parseData(item: MovieResult) {
        fetchImgPoster(path: item.poster_path)
        txtTitle.text = item.title
        txtRelease.text = "Release: \(item.release_date?.toDateString() ?? "-")"
        txtVote.text = "\(item.vote_average ?? 0.0)"
        txtOverview.text = item.overview
    }

    private func fetchImgPoster(path: String?) {
        guard let path = path else {return}

        imgPosterIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path) { (data) in
            self.imgPoster.image = UIImage(data: data)
            self.imgPoster.contentMode = .scaleAspectFill
            self.imgPosterIndicator.stopAnimating()
        }
    }
}
