//
//  ProgressHeaderView.swift
//  Today
//
//  Created by Huy Bui on 2023-05-04.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    var noAnimation = true
    var progress: CGFloat = 0 {
        didSet {
            setNeedsLayout()
            heightConstraint?.constant = progress * bounds.height
            if noAnimation {
                noAnimation = false
                return
            }
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.05) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let container = UIView(frame: .zero)
    
    private var heightConstraint: NSLayoutConstraint?
    private var valueFormat: String {
        NSLocalizedString("%d percent", comment: "Progress percentage value format")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        
        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("Progress", comment: "Progress view accessibility label")
        accessibilityTraits.update(with: .updatesFrequently)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accessibilityValue = String(format: valueFormat, Int(progress * 100))
        heightConstraint?.constant = progress * bounds.height
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 0.5 * container.bounds.width
    }
    
    private func prepareSubviews() {
        container.addSubview(upperView)
        container.addSubview(lowerView)
        addSubview(container)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            
            container.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            upperView.topAnchor.constraint(equalTo: topAnchor),
            upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor),
            lowerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            upperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            upperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lowerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        
        backgroundColor = .clear
        container.backgroundColor = .clear
        upperView.backgroundColor = .todayProgressUpperBackground
        lowerView.backgroundColor = .todayProgressLowerBackground
    }
}
