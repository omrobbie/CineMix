//
//  MovieDetailVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    var data: MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(data?.title)
    }
}
