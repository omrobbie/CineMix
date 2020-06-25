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
    @IBOutlet weak var tableView: UITableView!

    var data: Cast?
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        setupList()
        fetchData()
    }

    private func showData() {
        fetchImgPerson(path: data?.profile_path)
        txtName.text = data?.name
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.biographyCell, bundle: nil), forCellReuseIdentifier: Nib.biographyCell)
    }

    private func fetchData() {
        guard let personId = data?.id else {return}

        ApiService.shared.getPersonDetail(personId: personId) { (data) in
            self.person = data
            self.txtBirthDay.text = "Birthday: \(data.birthday?.toDateString() ?? "-")"
            self.txtBirthPlace.text = "Place of Birth: \(data.place_of_birth ?? "-")"
            self.tableView.reloadData()
        }
    }
}

extension CreditDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            tableView.rowHeight = UITableView.automaticDimension
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.biographyCell) as! BiographyCell

            if let item = person {
                cell.parseData(item: item)
            }

            return cell
        default:
            return UITableViewCell()
        }
    }
}
