//
//  CreditDetailVC.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class CreditDetailVC: UIViewController {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var imgPersonIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtBirthDay: UILabel!
    @IBOutlet weak var txtBirthPlace: UILabel!
    @IBOutlet weak var txtBiography: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var data: Cast?

    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        setupList()
    }

    private func showData() {
        fetchImgPerson(path: data?.profile_path)
        txtName.text = data?.name
        txtBirthDay.text = "Birthday: -"
        txtBirthPlace.text = "Place of Birth: -"
        txtBiography.text = "Biography"
    }

    private func fetchImgPerson(path: String?) {
        guard let path = path else {return}

        imgPersonIndicator.startAnimating()
        ApiService.shared.downloadImage(path: path, size: .small) { (data) in
            self.imgPerson.image = UIImage(data: data)
            self.imgPerson.contentMode = .scaleAspectFill
            self.imgPersonIndicator.stopAnimating()
        }
    }

    private func setupList() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CreditDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
