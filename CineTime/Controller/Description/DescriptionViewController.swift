//
//  DescriptionViewController.swift
//  CineTime
//
//  Created by Beatriz Carlos on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit
import WebKit

class DescriptionViewController: UIViewController, WKUIDelegate, UIWebViewDelegate {
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = .black
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var dataFilm = [Film]()
    // Results API category.
    func callAPI() {
        Service.shared.getTrailer(filmId: String(dataFilm[0].id)) { (result) in
            var keyYT : String = ""
            for trailer in result! {
                keyYT = trailer.key
            }
            self.loadTrailer(key: keyYT)
        }
    }
    
    lazy var viewDescription: UIView = {
        let viewDescription = DescriptionView(frame: .zero, data: dataFilm)
        return viewDescription
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callAPI()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        //loadTrailer()
        configureWebView()
        configureViewDescription()
    }
    
    func loadTrailer(key: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(key)")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func configureWebView(){
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/10)
        ])
    }
    
    func configureViewDescription() {
        view.addSubview(viewDescription)
        NSLayoutConstraint.activate([
            viewDescription.topAnchor.constraint(equalTo: webView.bottomAnchor),
            viewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
