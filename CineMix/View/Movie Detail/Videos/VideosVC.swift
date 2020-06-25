//
//  VideosVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class VideosVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: MovieResult?

    private var videos: [VideosResults]?

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
        fetchData()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.videosCell, bundle: nil), forCellReuseIdentifier: Nib.videosCell)
    }

    private func fetchData() {
        guard let movieId = data?.id else {return}

        ApiService.shared.getVideos(movieId: movieId) { (data) in
            self.videos = data
            self.tableView.reloadData()
        }
    }
}

extension VideosVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nib.videosCell) as! VideosCell

        if let item = videos?[indexPath.row] {
            cell.parseData(item: item)
        }
        return cell
    }
}
