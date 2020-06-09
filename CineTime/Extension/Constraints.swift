//
//  Constraints.swift
//  CineTime
//
//  Created by Beatriz Carlos on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

extension UIView {

    var top: NSLayoutYAxisAnchor { get { return self.topAnchor } }
    var right: NSLayoutXAxisAnchor { get { self.rightAnchor } }
    var bottom: NSLayoutYAxisAnchor { get { self.bottomAnchor } }
    var left: NSLayoutXAxisAnchor { get { self.leftAnchor } }
    var leading: NSLayoutXAxisAnchor { get { self.leadingAnchor } }
    var trailing: NSLayoutXAxisAnchor { get { self.trailingAnchor } }
    var x: NSLayoutXAxisAnchor { get { return self.centerXAnchor } }
    var y: NSLayoutYAxisAnchor { get { return self.centerYAnchor } }
    
    var safe: ( top: NSLayoutYAxisAnchor,
                right: NSLayoutXAxisAnchor,
                bottom: NSLayoutYAxisAnchor,
                left: NSLayoutXAxisAnchor,
                leading: NSLayoutXAxisAnchor,
                trailing: NSLayoutXAxisAnchor,
                x: NSLayoutXAxisAnchor,
                y: NSLayoutYAxisAnchor
            )
        {
        get { return ( top: self.safeAreaLayoutGuide.topAnchor,
                       right: self.safeAreaLayoutGuide.rightAnchor,
                       bottom: self.safeAreaLayoutGuide.bottomAnchor,
                       left: self.safeAreaLayoutGuide.leftAnchor,
                       leading: self.safeAreaLayoutGuide.leadingAnchor,
                       trailing: self.safeAreaLayoutGuide.trailingAnchor,
                       x: self.safeAreaLayoutGuide.centerXAnchor,
                       y: self.safeAreaLayoutGuide.centerYAnchor)
        }
    }
    
    // Método de validação caso não consiga usar os métodos abaixo.
    public func added() {
        guard let _ = self.superview else {
            fatalError("Insert this view into another to use this method")
        }
    }
    
    public func centerAlign(_ reference: UIView) {
        self.horizontalAlignment(reference)
        self.verticalAlignment(reference)
    }

    public func verticalAlignment(_ reference: UIView, _ margin: Int = 0) {
        self.safe.x.constraint(equalTo: reference.safe.x, constant: CGFloat(margin)).isActive = true
    }
    public func horizontalAlignment(_ reference: UIView, _ margin: Int = 0) {
        self.safe.y.constraint(equalTo: reference.safe.y, constant: CGFloat(margin)).isActive = true
    }

    public func fillX(_ margin: Int = 0) {
        self.added()
        self.safe.leading.constraint(equalTo: self.superview!.safe.leading, constant: CGFloat(margin)).isActive = true
        self.safe.trailing.constraint(equalTo: self.superview!.safe.trailing, constant: CGFloat(-margin)).isActive = true
    }

    public func fillY(_ margin: Int = 0) {
        self.added()
        self.safe.top.constraint(equalTo: self.superview!.top, constant: CGFloat(margin)).isActive = true
        self.safe.bottom.constraint(equalTo: self.superview!.bottom, constant: CGFloat(-margin)).isActive = true
    }

    public func fill(_ margin: Int = 0) {
        self.added()
        self.leading.constraint(equalTo: self.superview!.leading, constant: CGFloat(margin)).isActive = true
        self.trailing.constraint(equalTo: self.superview!.trailing, constant: CGFloat(-margin)).isActive = true
        self.top.constraint(equalTo: self.superview!.top, constant: CGFloat(margin)).isActive = true
        self.bottom.constraint(equalTo: self.superview!.bottom,constant: CGFloat(-margin)).isActive = true
    }

    public func fillSafe(_ margin: Int = 0) {
        self.added()
        self.safe.leading.constraint(equalTo: self.superview!.safe.leading, constant: CGFloat(margin)).isActive = true
        self.safe.trailing.constraint(equalTo: self.superview!.safe.trailing, constant: CGFloat(-margin)).isActive = true
        self.safe.top.constraint(equalTo: self.superview!.safe.top, constant: CGFloat(margin)).isActive = true
        self.safe.bottom.constraint(equalTo: self.superview!.safe.bottom,constant: CGFloat(-margin)).isActive = true
    }
    
    func tableview(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
