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
    @IBOutlet weak var tableViewIndicator: UIActivityIndicatorView!
    
    var type: MovieType?
    var genre: Genre?

    private var movie: Movie?
    private var data = [MovieResult]()
    private var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEnv()
        setupList()
        fetchData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.listToDetail {
            let vc = segue.destination as! MovieDetailVC
            vc.data = sender as? MovieResult
        }
    }

    private func setupEnv() {
        guard var title = type?.rawValue else {return}

        if type == .genre {
            if let name = genre?.name {
                title += name
            }
        }

        self.title = title
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.movieCell, bundle: nil), forCellReuseIdentifier: Nib.movieCell)
    }

    private func fetchData() {
        switch type {
        case .genre: fetchDataGenre()
        case .nowPlaying: fetchDataNowPlaying()
        case .upComing: fetchDataUpComing()
        case .topRated: fetchDataTopRated()
        case .popular: fetchDataPopular()
        default: break
        }
    }

    private func fetchDataGenre() {
        guard let genreId = genre?.id else {return}

        tableViewIndicator.startAnimating()
        ApiService.shared.getDiscover(page: page, genres: "\(genreId)") { (data) in
            self.movie = data

            if let results = data.results {
                self.data.append(contentsOf: results)
            }

            self.tableView.reloadData()
            self.tableViewIndicator.stopAnimating()
        }
    }

    private func fetchDataNowPlaying() {
        tableViewIndicator.startAnimating()
        ApiService.shared.getNowPlaying(page: page) { (data) in
            self.movie = data

            if let results = data.results {
                self.data.append(contentsOf: results)
            }

            self.tableView.reloadData()
            self.tableViewIndicator.stopAnimating()
        }
    }

    private func fetchDataUpComing() {

    }

    private func fetchDataTopRated() {

    }

    private func fetchDataPopular() {

    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.movieCell) as! MovieCell

        let item = data[indexPath.row]
        cell.parseData(item: item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: Segue.listToDetail, sender: item)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if movie?.total_pages ?? 1 > page {
                page += 1
                fetchData()
            }
        }
    }
}
