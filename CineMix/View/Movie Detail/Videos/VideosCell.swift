//
//  VideosCell.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import WebKit

class VideosCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var imgThumbnailIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtSite: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var layerImage: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webViewIndicator: UIActivityIndicatorView!

    func parseData(item: VideosResults) {
        fetchImgThumbnail(path: item.key)
        txtName.text = item.name
        txtSite.text = "Site: \(item.site ?? "-")"
        txtType.text = "Type: \(item.type ?? "-")"

        setupGesture(key: item.key)
    }

    private func fetchImgThumbnail(path: String?) {
        guard let path = path else {return}

        imgThumbnailIndicator.startAnimating()
        ApiService.shared.downloadVideoThumbnail(path: path) { (data) in
            self.imgThumbnail.image = UIImage(data: data)
            self.imgThumbnail.contentMode = .scaleAspectFill
            self.imgThumbnailIndicator.stopAnimating()
            self.layerView.isHidden = false
            self.layerImage.isHidden = false
        }
    }

    private func setupGesture(key: String?) {
        guard let key = key else {return}
        let tap = TapGesture(target: self, action: #selector(playVideo(_:)))
        tap.key = key
        layerView.addGestureRecognizer(tap)
    }

    @objc private func playVideo(_ sender: TapGesture) {
        guard let url = URL(string: "\(Constant.urlYouTube)\(sender.key)") else {return}


        webView.isHidden = false
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
        webViewIndicator.startAnimating()
    }

    // MARK: - Pass value with gesture
    class TapGesture: UITapGestureRecognizer {
        var key = String()
    }
}

extension VideosCell: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webViewIndicator.stopAnimating()
    }
}
