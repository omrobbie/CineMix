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

    var delegate: ReviewsDetailDelegate?
    
    var data: MovieResult?

    private var reviews: Reviews?
    private var reviewsResults = [ReviewsResults]()
    private var page = 1

    init(_ data: MovieResult?, delegate: ReviewsDetailDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
        fetchData()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.reviewsCell, bundle: nil), forCellReuseIdentifier: Nib.reviewsCell)
    }

    private func fetchData() {
        guard let movieId = data?.id else {return}

        ApiService.shared.getReviews(page: page, movieId: movieId) { (data) in
            self.reviews = data

            if let results = data.results {
                self.reviewsResults.append(contentsOf: results)
            }

            self.tableView.reloadData()
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reviewsCell) as! ReviewsCell
        let item = reviewsResults[indexPath.row]
        cell.parseData(item: item)
       return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = reviewsResults[indexPath.row]
        delegate?.reviewDetail(item: item)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reviewsResults.count - 1 {
            if reviews?.total_pages ?? 1 > page {
                page += 1
                fetchData()
            }
        }
    }
}
