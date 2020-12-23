//
//  AdjustSize.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 22.12.2020.
//

import UIKit

class Device {
  // Base height in point, use iPhone 11
  static let base: CGFloat = 896
  static var ratio: CGFloat {
    return UIScreen.main.bounds.height / base
  }
}

extension CGFloat {
  var adjusted: CGFloat {
    return self * Device.ratio
  }
}
extension Double {
  var adjusted: CGFloat {
    return CGFloat(self) * Device.ratio
  }
}
extension Int {
  var adjusted: CGFloat {
    return CGFloat(self) * Device.ratio
  }
}

