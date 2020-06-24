//
//  HomeVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let nibNowPlaying = "NowPlayingCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: nibNowPlaying, bundle: nil), forCellReuseIdentifier: nibNowPlaying)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nibNowPlaying) as! NowPlayingCell
        cell.delegate = self
        tableView.rowHeight  = 290
        return cell
    }
}

extension HomeVC: MovieListDelegate {

    func seeAllMovies(type: MovieType) {
        performSegue(withIdentifier: "toMovieList", sender: self)
    }

    func movieDetail(item: MovieResult) {
        performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
}
