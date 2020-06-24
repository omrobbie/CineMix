//
//  MovieListVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var type: MovieType?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = type?.rawValue
        setupList()
    }

    func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }
}
