//
//  ReviewsDetailCell.swift
//  CineMix
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ReviewsDetailCell: UITableViewCell {

    @IBOutlet weak var txtAuthor: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtContent: UILabel!

    func parseData(item: ReviewsDetail) {
        txtAuthor.text = item.author
        txtTitle.text = item.media_title
        txtContent.text = item.content
    }
}
