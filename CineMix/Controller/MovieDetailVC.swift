//
//  MovieDetailVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgBackdropIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgPosterIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtReleaseDate: UILabel!
    @IBOutlet weak var txtVote: UILabel!

    var data: MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        showData()
    }

    func showData() {
        fetchImgBackdrop(path: data?.backdrop_path)
        fetchImgPoster(path: data?.poster_path)
        txtTitle.text = data?.title
        txtReleaseDate.text = "Release: \(data?.release_date?.toDateString() ?? "-")"
        txtVote.text = "\(data?.vote_average ?? 0.0)"
    }

    func fetchImgBackdrop(path: String?) {
        guard let path = path else {return}

        imgBackdropIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path) { (data) in
            self.imgBackdrop.image = UIImage(data: data)
            self.imgBackdrop.contentMode = .scaleAspectFill
            self.imgBackdropIndicator.stopAnimating()
        }
    }

    func fetchImgPoster(path: String?) {
        guard let path = path else {return}

        imgBackdropIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path) { (data) in
            self.imgPoster.image = UIImage(data: data)
            self.imgPoster.contentMode = .scaleAspectFill
            self.imgPosterIndicator.stopAnimating()
        }
    }
}
