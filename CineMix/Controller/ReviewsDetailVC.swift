//
//  ReviewsDetailVC.swift
//  CineMix
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ReviewsDetailVC: UIViewController {

    var data: ReviewsResults?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        print(data?.id)
    }
}
