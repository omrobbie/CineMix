//
//  OverviewCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {

    @IBOutlet weak var txtOverview: UILabel!

    func parseData(item: MovieResult) {
        txtOverview.text = item.overview
    }
}
