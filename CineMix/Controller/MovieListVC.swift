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

    private var data: Movie?
    private var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEnv()
        setupList()
        fetchData()
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
            self.data = data
            self.tableView.reloadData()
            self.tableViewIndicator.stopAnimating()
        }
    }

    private func fetchDataNowPlaying() {

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
        return data?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.movieCell) as! MovieCell

        if let item = data?.results?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = data?.results?[indexPath.row] {
            print(item.title ?? "")
        }
    }
}
