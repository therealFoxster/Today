//
//  UIContentConfiguration+Stateless.swift
//  Today
//
//  Created by Huy Bui on 2023-05-03.
//

import UIKit

extension UIContentConfiguration {
    func updated(for state: UIConfigurationState) -> Self {
        // Provide specialized configuration for a given state (normal|highlighted|selected).
        return self
    }
}
