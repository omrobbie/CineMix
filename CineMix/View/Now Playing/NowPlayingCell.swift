//
//  NowPlayingCell.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class NowPlayingCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private let nibName = "NowPlayingItem"

    private var data: Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupList()
        fetchData()
    }

    private func setupList() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }

    private func fetchData() {
        ApiService.shared.getNowPlaying { (data) in
            self.data = data
            self.collectionView.reloadData()
        }
    }

    @IBAction func btnSeeAllTapped(_ sender: Any) {
        print(#function)
    }
}

extension NowPlayingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as! NowPlayingItem

        if let item = data?.results?[indexPath.row] {
            cell.parseData(item: item)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = contentView.bounds.width
        return CGSize(width: width, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = data?.results?[indexPath.row] {
            print(item.title ?? "")
        }
    }
}
