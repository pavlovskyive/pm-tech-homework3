//
//  RoundedButton.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 20.12.2020.
//

import UIKit

// Button with rounded corners

@IBDesignable class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Users love when everything responds to their actions, so I added an animation on user's press
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut,
                animations: {
                    self.alpha = self.isHighlighted ? 0.8 : 1
                    let scaleFactor: CGFloat = self.isHighlighted ? 0.95 : 1.0
                    self.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                })
        }
    }
    
    // Dim button if it's disabled
    override open var isEnabled: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    self.alpha = self.isEnabled ? 1.0 : 0.5
                })
        }
    }
    
    private func setup() {
        layer.cornerRadius = 8
        backgroundColor = .systemRed
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .title3, weight: .bold)
        titleLabel?.adjustsFontForContentSizeCategory = true
        contentEdgeInsets = UIEdgeInsets(top: 15.adjusted, left: 0, bottom: 15.adjusted, right: 0)
    }
}
