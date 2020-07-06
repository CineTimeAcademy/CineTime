//
//  DescriptionViewController.swift
//  CineTime
//
//  Created by Beatriz Carlos on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit
import WebKit

class DescriptionViewController: UIViewController {
    
    var dataFilm: Film? = nil
    let repository = FilmRepository(with: "assistidos")
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 0
        return stackview
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = .black
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var viewDescription: DescriptionView = {
        let viewDescription = DescriptionView(frame: .zero, data: dataFilm!)
        viewDescription.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        return viewDescription
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        addSubviews()
        configureAutoLayout()
        callAPI()
        streamingRequest()
        checkMyList()
        viewDescription.myListButton.addTarget(self, action: #selector(pressedButtonHeader), for: .touchUpInside)
    }
    
    @objc func pressedButtonHeader() {
        guard let dataFilm = dataFilm else { return }
        
        guard let _ = dataFilm.streamings else { return }
        
        viewDescription.myListButton.isSelected = !viewDescription.myListButton.isSelected
        
        if viewDescription.myListButton.isSelected {
            repository.add(object: dataFilm)
        } else {
            repository.delete(object: dataFilm)
        }
    }
    
    func checkMyList() {
        guard let dataFilm = dataFilm else { return }
        
        let filmsWatched = repository.getAll()
        
        if filmsWatched.contains(dataFilm) {
            viewDescription.myListButton.isSelected = true
        }
        
    }
    
    func streamingRequest() {
        guard var dataFilm = dataFilm else { return }
        
        if dataFilm.streamings == nil {
            
            Service.shared.getStreamings (tmdb_id: String(dataFilm.id)) { streamings in
                if let streamings = streamings {
                    dataFilm.streamings = streamings
                    self.dataFilm = dataFilm
                    
                    guard let streamings = dataFilm.streamings else { return }
                    
                    for streaming in streamings {
                        self.viewDescription.streaming = streaming
                    }
                }
            }
        }
            
        else {
            
            guard let streamings = dataFilm.streamings else { return }
            
            for streaming in streamings {
                self.viewDescription.streaming = streaming
            }
        }
        
        
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(webView)
        stackView.addArrangedSubview(viewDescription)
    }
    
    // Results API category.
    func callAPI() {
        guard let dataFilm = dataFilm else { return }
        
        if dataFilm.streamings == nil {
            Service.shared.getTrailer(filmId: String(dataFilm.id), mediaType: dataFilm.media_type ?? "movie") { (result) in
                var keyYT : String = ""
                
                for trailer in result! {
                    keyYT = trailer.key
                }
                self.loadTrailer(key: keyYT)
            }
        }
        
       
    }
    
    
    // Load video from youtube.
    func loadTrailer(key: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(key)")
        let request = URLRequest(url: url!)
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
}

extension DescriptionViewController {
    func configureAutoLayout() {
        // Description
        NSLayoutConstraint.activate([
            viewDescription.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            viewDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        // Web View
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            webView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/10)
        ])
        
        // Scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        
        // Stack view
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
