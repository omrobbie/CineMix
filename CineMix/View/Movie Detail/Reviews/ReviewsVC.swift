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
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.reviewsCell) as! ReviewsCell
        cell.txtContent.text = "Item \(indexPath.row)"
        return cell
    }
}
