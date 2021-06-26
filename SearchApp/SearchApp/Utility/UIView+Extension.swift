//
//  UIView+Extension.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import UIKit

extension UIView {
    
    func pin(to view: UIView, constant: UIEdgeInsets? = nil) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant?.left ?? 0),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant?.right ?? 0),
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant?.top ?? 0),
        ])
        let bottomAnchor = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant?.bottom ?? 0)
        bottomAnchor.priority = UILayoutPriority(rawValue: 998)
        bottomAnchor.isActive = true
    }
}
