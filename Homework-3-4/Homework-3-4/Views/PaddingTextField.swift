//
//  PaddingTextField.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 20.12.2020.
//

import UIKit

// Text field with padding (insets)

class PaddingTextField: UITextField {

    var textPadding = UIEdgeInsets(top: 10.adjusted, left: 0, bottom: 10.adjusted, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
