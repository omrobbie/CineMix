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
    @IBOutlet weak var viewContainer: UIView!

    var data: MovieResult?

    private var views = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        showData()
        prepareSegmentationView()
    }

    private func showData() {
        fetchImgBackdrop(path: data?.backdrop_path)
        fetchImgPoster(path: data?.poster_path)
        txtTitle.text = data?.title
        txtReleaseDate.text = "Release: \(data?.release_date?.toDateString() ?? "-")"
        txtVote.text = "\(data?.vote_average ?? 0.0)"
    }

    private func prepareSegmentationView() {
        views.append(MainVC().view)
        views.append(VideosVC().view)
        views.append(ReviewsVC().view)

        views.forEach {
            $0.frame = view.frame
            viewContainer.addSubview($0)
        }

        viewContainer.bringSubviewToFront(views[0])
    }

    private func fetchImgBackdrop(path: String?) {
        guard let path = path else {return}

        imgBackdropIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path) { (data) in
            self.imgBackdrop.image = UIImage(data: data)
            self.imgBackdrop.contentMode = .scaleAspectFill
            self.imgBackdropIndicator.stopAnimating()
        }
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

    @IBAction func segmentationChanged(_ sender: UISegmentedControl) {
        viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
}
