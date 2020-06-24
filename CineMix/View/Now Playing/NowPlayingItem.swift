//
//  NowPlayingItem.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class NowPlayingItem: UICollectionViewCell {

    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgBackdropIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtTitle: UILabel!

    func parseData(item: MovieResult) {
        txtTitle.text = item.title
        fetchImgBackdrop(path: item.backdrop_path)
    }

    private func fetchImgBackdrop(path: String?) {
        guard let path = path else {return}

        imgBackdropIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path, size: .large) { (data) in
            self.imgBackdrop.image = UIImage(data: data)
            self.imgBackdrop.contentMode = .scaleAspectFill
            self.imgBackdropIndicator.stopAnimating()
        }
    }
}
