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
        tableView.register(UINib(nibName: Nib.movieCell, bundle: nil), forCellReuseIdentifier: Nib.movieCell)
        tableView.register(UINib(nibName: Nib.genresCell, bundle: nil), forCellReuseIdentifier: Nib.genresCell)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 290

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.movieCell) as! MovieCell
            cell.delegate = self
            cell.fetchData(type: .nowPlaying)
            return cell
        case 1:
            tableView.rowHeight = 120
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.genresCell) as! GenresCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.movieCell) as! MovieCell
            cell.delegate = self
            cell.fetchData(type: .upComing)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeVC: MovieListDelegate, GenreDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toMovieList {
            let vc = segue.destination as! MovieListVC

            if sender is Genre {
                vc.type = .genre
                vc.genre = sender as? Genre
            } else {
                vc.type = sender as? MovieType
            }
        }

        if segue.identifier == Segue.toMovieDetail {
            let vc = segue.destination as! MovieDetailVC
            vc.data = sender as? MovieResult
        }
    }

    func seeAllMovies(genre: Genre) {
        performSegue(withIdentifier: Segue.toMovieList, sender: genre)
    }

    func seeAllMovies(type: MovieType) {
        performSegue(withIdentifier: Segue.toMovieList, sender: type)
    }

    func movieDetail(item: MovieResult) {
        performSegue(withIdentifier: Segue.toMovieDetail, sender: item)
    }
}
