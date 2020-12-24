//
//  EasyLocalization.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 24.12.2020.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
