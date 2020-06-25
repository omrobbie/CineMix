//
//  MoviesItem.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MoviesItem: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgPosterIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTitle: UILabel!

    func parseData(item: MovieResult) {
        fetchImgPoster(path: item.poster_path)
        txtTitle.text = item.title
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
