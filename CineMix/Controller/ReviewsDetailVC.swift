//
//  ReviewsDetailVC.swift
//  CineMix
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ReviewsDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: ReviewsResults?

    private var reviewsDetail: ReviewsDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        setupList()
        fetchData()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.reviewsDetailCell, bundle: nil), forCellReuseIdentifier: Nib.reviewsDetailCell)
    }

    private func fetchData() {
        guard let reviewId = data?.id else {return}

        print(reviewId)

        ApiService.shared.getReviewsDetail(reviewId: reviewId) { (data) in
            self.reviewsDetail = data
            self.tableView.reloadData()
        }
    }
}

extension ReviewsDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reviewsDetailCell) as! ReviewsDetailCell

        if let item = reviewsDetail {
            cell.parseData(item: item)
        }

        return cell
    }
}
