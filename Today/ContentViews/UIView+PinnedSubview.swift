//
//  UIView+PinnedSubview.swift
//  Today
//
//  Created by Huy Bui on 2023-05-03.
//

import UIKit

extension UIView {
    func addPinnedSubview(_ subview: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subview) // Add subview to the bottom of superview's view hierarchy.
        subview.translatesAutoresizingMaskIntoConstraints = false // Prevent system from creating automatic constraints for subview.
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
