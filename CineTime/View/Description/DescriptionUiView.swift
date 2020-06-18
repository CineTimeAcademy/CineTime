//
//  DescriptioUiView.swift
//  CineTime
//
//  Created by Beatriz Carlos on 18/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit
import WebKit

class DescriptionUiView: UIView {
    lazy var viewDescription: UIView = {
        let viewDescription = Description(frame: .zero)
        viewDescription.translatesAutoresizingMaskIntoConstraints = false
        viewDescription.backgroundColor = .black
        viewDescription.layer.cornerRadius = 20
        return viewDescription
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(viewDescription)
        configureViewDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
