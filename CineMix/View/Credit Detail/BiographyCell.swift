//
//  BiographyCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class BiographyCell: UITableViewCell {

    @IBOutlet weak var txtBiography: UILabel!

    func parseData(item: Person) {
        txtBiography.text = item.biography
    }
}
