//
//  CinemaScreenView.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

final class CinemaScreenView: UIView {
  
  var playerLayer: AVPlayerLayer! {
    didSet { self.layer.addSublayer(playerLayer) }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    playerLayer.frame = self.bounds
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor     = Constants.Colors.DarkGray.getColor()
    layer.cornerRadius  = Constants.defaultViewLayerCornerRadius
    layer.masksToBounds = true
    layer.borderColor   = Constants.Colors.DarkGray.getColor().CGColor
    layer.borderWidth   = 2
    
  }
  
}
