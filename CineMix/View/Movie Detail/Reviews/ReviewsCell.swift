//
//  ReviewsCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ReviewsCell: UITableViewCell {

    @IBOutlet weak var txtAuthor: UILabel!
    @IBOutlet weak var txtContent: UILabel!

    func parseData(item: ReviewsResults) {
        txtAuthor.text = item.author
        txtContent.text = item.content
    }
}
