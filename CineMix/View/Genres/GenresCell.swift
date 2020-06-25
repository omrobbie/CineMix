//
//  GenresCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GenresCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    private var data: [Genre]?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupList()
        fetchData()
    }

    private func setupList() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Nib.genresItem, bundle: nil), forCellWithReuseIdentifier: Nib.genresItem)
    }

    private func fetchData() {
        ApiService.shared.getGenresMovie { (data) in
            self.data = data
            self.collectionView.reloadData()
        }
    }
}

extension GenresCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Nib.genresItem, for: indexPath) as! GenresItem

        if let item = data?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 100

        if let item = data?[indexPath.row],
            let name = item.name {
            width += name.count * 5
        }

        return CGSize(width: width, height: 68)
    }
}
