//
//  RoundedView.swift
//  Homework-3-1-2
//
//  Created by Vsevolod Pavlovskyi on 24.12.2020.
//

import UIKit

@IBDesignable class RoundedView: UIView {}

extension RoundedView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
