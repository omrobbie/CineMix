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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.nowPlayingCell, bundle: nil), forCellReuseIdentifier: Nib.nowPlayingCell)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.nowPlayingCell) as! NowPlayingCell
        cell.delegate = self
        tableView.rowHeight  = 290
        return cell
    }
}

extension HomeVC: MovieListDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toMovieList {

        }

        if segue.identifier == Segue.toMovieList {

        }
    }

    func seeAllMovies(type: MovieType) {
        performSegue(withIdentifier: Segue.toMovieList, sender: self)
    }

    func movieDetail(item: MovieResult) {
        performSegue(withIdentifier: Segue.toMovieDetail, sender: self)
    }
}
