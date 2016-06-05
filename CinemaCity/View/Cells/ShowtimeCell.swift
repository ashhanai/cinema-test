//
//  ShowtimeCell.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 21.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

class ShowtimeCell: UICollectionViewCell {
  
  @IBOutlet private weak var showtimeLabel: UILabel!
  
  var showtime: String! {
    didSet {
      showtimeLabel.text = showtime
    }
  }
  
}
