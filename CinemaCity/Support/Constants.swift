//
//  Constants.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 30.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

struct Constants {
  
  enum Colors: String {
    case BackgroundPink = "#FEFEF7"
    case DarkGray = "#2B2929"
    case DarkRed = "#E60000"
    
    func getColor(withAlpha alpha: CGFloat = 1.0) -> UIColor {
      return UIColor.colorFromHEX(self.rawValue, andAlpha: alpha)
    }
  }
  
  static let defaultViewLayerCornerRadius: CGFloat = 4
  static let defaultTransitionDuration = 0.7
  
}
