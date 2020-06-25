//
//  TopCreditItem.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class TopCreditItem: UICollectionViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var imgPersonIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtCharacter: UILabel!

    func parseData(item: Cast) {
        fetchImgPerson(path: item.profile_path)
        txtName.text = item.name
        txtCharacter.text = item.character
    }

    private func fetchImgPerson(path: String?) {
        guard let path = path else {return}

        imgPersonIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path, size: .small) { (data) in
            self.imgPerson.image = UIImage(data: data)
            self.imgPerson.contentMode = .scaleAspectFill
            self.imgPersonIndicator.stopAnimating()
        }
    }
}
