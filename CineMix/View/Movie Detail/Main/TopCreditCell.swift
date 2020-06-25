//
//  TopCreditCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class TopCreditCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var data: [Cast]?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupList()
    }

    func fetchData(data: MovieResult?) {
        guard let movieId = data?.id else {return}

        ApiService.shared.getMovieCredits(movieId: movieId) { (data) in
            self.data = data
            self.collectionView.reloadData()
        }
    }

    private func setupList() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Nib.topCreditItem, bundle: nil), forCellWithReuseIdentifier: Nib.topCreditItem)
    }
}

extension TopCreditCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.topCreditItem, for: indexPath) as! TopCreditItem

        if let item = data?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = data?[indexPath.row] {
            print(item.name ?? "")
        }
    }
}
