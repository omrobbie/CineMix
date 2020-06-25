//
//  ReviewsVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ReviewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: MovieResult?

    private var reviews: [ReviewsResults]?

    init(_ data: MovieResult?) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.reviewsCell, bundle: nil), forCellReuseIdentifier: Nib.reviewsCell)
    }

    private func fetchData() {
        guard let movieId = data?.id else {return}

        ApiService.shared.getReviews(movieId: movieId) { (data) in
            self.reviews = data
            self.tableView.reloadData()
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reviewsCell) as! ReviewsCell

        if let item = reviews?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }
}
