//
//  MainVC.swift
//  CineMix
//
//  Created by omrobbie on 24/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var delegate: CreditDetailDelegate?

    var data: MovieResult?

    init(_ data: MovieResult?, delegate: CreditDetailDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }

    private func setupList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nib.overviewCell, bundle: nil), forCellReuseIdentifier: Nib.overviewCell)
        tableView.register(UINib(nibName: Nib.topCreditCell, bundle: nil), forCellReuseIdentifier: Nib.topCreditCell)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            tableView.rowHeight = UITableView.automaticDimension
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.overviewCell) as! OverviewCell
            cell.txtOverview.text = data?.overview ?? ""
            return cell
        case 1:
            tableView.rowHeight = 260
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.topCreditCell) as! TopCreditCell
            cell.delegate = self
            cell.fetchData(data: data)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainVC: CreditDetailDelegate {

    func creditDetail(item: Cast) {
        delegate?.creditDetail(item: item)
    }
}
