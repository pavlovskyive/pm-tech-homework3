//
//  PreferredFontTraits.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 23.12.2020.
//

import UIKit

// This extension helps to set a weight to preffered font. I don't know why Apple didn't implement that by default.

extension UIFont {
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
