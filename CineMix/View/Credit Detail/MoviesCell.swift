//
//  MoviesCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    private var data: [MovieResult]?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupList()
    }

    func fetchData(data: Cast?) {
        guard let personId = data?.id else {return}

        ApiService.shared.getDiscover(genres: nil, people: "\(personId)") { (data) in
            self.data = data.results
            self.collectionView.reloadData()
        }
    }

    private func setupList() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Nib.moviesItem, bundle: nil), forCellWithReuseIdentifier: Nib.moviesItem)
    }
}

extension MoviesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.moviesItem, for: indexPath) as! MoviesItem

        if let item = data?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 245)
    }
}
