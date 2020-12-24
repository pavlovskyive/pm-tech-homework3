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

// This extension adjusts sizes depending on device height proportions to iPhone 11, which was a base device I made layout for. I don't know if this is a legit solution, but this was pretty handy for this assignment. Original solution was used when iPhone 6 was published and it had different width to height ratio, so developers made this kind of solution for handling those ratio differences. In that case it was width that differed more but in my case height difference is more important.

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

