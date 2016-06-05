//
//  MovieInfoView.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 14.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class MovieInfoView: UIView {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var showtimeLabel: UILabel!
  @IBOutlet weak var sectionLabel: UILabel!
  
  var name: String! {
    didSet { self.nameLabel.text = name }
  }
  var showtime: String! {
    didSet { self.showtimeLabel.text = showtime }
  }
  var section: Int! {
    didSet { self.sectionLabel.text = "- SECTION \(section)" }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.layer.cornerRadius = Constants.defaultViewLayerCornerRadius
    self.backgroundColor = Constants.Colors.DarkGray.getColor()
  }
  
}