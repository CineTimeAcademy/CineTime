//
//  HeaderTableView.swift
//  teste
//
//  Created by Beatriz Carlos on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class HeaderTableView: UIView {
    
    var section: Int = 0
    
    lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 41))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        label.text = "Categorias"
        return label
    }()
    
    lazy var button : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "seta"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func configureConstraintsButton() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            button.widthAnchor.constraint(equalToConstant: 30.0),
            button.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(label)
        self.backgroundColor = .black
        addSubview(button)
        configureConstraintsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
