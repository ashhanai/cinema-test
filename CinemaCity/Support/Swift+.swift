//
//  Globals.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 26.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import Foundation

extension Int {
  
  var timeString: String {
    return "\(self/60)H\(self%60)"
  }
  
}