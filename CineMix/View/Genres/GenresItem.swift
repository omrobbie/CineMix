//
//  GenresItem.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GenresItem: UICollectionViewCell {

    @IBOutlet weak var txtName: UILabel!

    func parseData(item: Genre) {
        txtName.text = item.name
    }
}
