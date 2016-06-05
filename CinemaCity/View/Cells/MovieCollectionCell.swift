//
//  MovieCollectionCell.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionCell: UICollectionViewCell {
  
  @IBOutlet private weak var moviePicView   : UIImageView!
  @IBOutlet private weak var movieNameLabel : UILabel!
  
  var movieShortcut: MovieShortcut? {
    didSet {
      movieNameLabel.text = movieShortcut?.name.uppercaseString
      moviePicView.image = movieShortcut?.picture
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.cornerRadius = 4
    layer.speed = 0.3
    moviePicView.backgroundColor = UIColor.lightGrayColor()
    self.backgroundColor = Constants.Colors.DarkGray.getColor()
  }

}
