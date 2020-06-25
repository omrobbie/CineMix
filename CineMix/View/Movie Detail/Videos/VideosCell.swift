//
//  VideosCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class VideosCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var imgThumbnailIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtSite: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var layerImage: UIImageView!

    func parseData(item: VideosResults) {
        fetchImgThumbnail(path: item.key)
        txtName.text = item.name
        txtSite.text = "Site: \(item.site ?? "-")"
        txtType.text = "Type: \(item.type ?? "-")"
    }

    private func fetchImgThumbnail(path: String?) {
        guard let path = path else {return}

        imgThumbnailIndicator.startAnimating()
        ApiService.shared.downloadVideoThumbnail(path: path) { (data) in
            self.imgThumbnail.image = UIImage(data: data)
            self.imgThumbnail.contentMode = .scaleAspectFill
            self.imgThumbnailIndicator.stopAnimating()
            self.layerView.isHidden = false
            self.layerImage.isHidden = false
        }
    }
}
