//
//  MyListCollectionViewCell.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MyListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cellId"
    var isFiltering: Bool = false
    
    lazy var streamingTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(12)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Prime Video"
        return label
    }()
    
    lazy var background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(background)
        background.addSubview(streamingTitle)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            streamingTitle.leadingAnchor.constraint(equalTo: self.background.leadingAnchor, constant: 8),
            streamingTitle.trailingAnchor.constraint(equalTo: self.background.trailingAnchor, constant: -8),
            streamingTitle.topAnchor.constraint(equalTo: self.background.topAnchor, constant: 5),
            streamingTitle.bottomAnchor.constraint(equalTo: self.background.bottomAnchor, constant: -5)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MyListCollectionViewCell {
    
    // Function to switch view appearence when tap on collection item
    func switchStateWhenSelected(cell: MyListCollectionViewCell) {
        if !cell.isFiltering {
            cell.background.backgroundColor = .actionColor
            cell.streamingTitle.textColor = .black
            cell.background.layer.borderWidth = 0
            cell.isFiltering = true
        } else {
            cell.isFiltering = false
            cell.streamingTitle.textColor = .white
            cell.background.backgroundColor = .clear
            cell.background.layer.borderWidth = 1
            cell.background.layer.borderColor = UIColor.white.cgColor
        }
        
    }
    
}

