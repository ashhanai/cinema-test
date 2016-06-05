//
//  SeatsView.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class SeatsView: UIView {
  
  @IBOutlet weak var seatsFloorView: SeatsFloorView!
  @IBOutlet weak var seatsFloorFrontView: UIView!
  @IBOutlet var seatButtons: [UIButton]!
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    let topColor = UIColor(hexString: "#2D2D2D")
    let bottomColor = UIColor(hexString: "#5F5F5F")
    
    seatsFloorView.backgroundColor =
      UIColor(gradientStyle: .TopToBottom, withFrame: seatsFloorView.bounds, andColors: [topColor, bottomColor])
    seatsFloorFrontView.backgroundColor = bottomColor.darkenByPercentage(0.2)
  }
  
}

final class SeatsFloorView: UIView {
  
  let slantDelta: CGFloat = 30
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    let slantLayer = CAShapeLayer()
    slantLayer.frame = rect
    
    let slantPath = UIBezierPath()
    slantPath.moveToPoint(    CGPoint(x: slantDelta,              y: 0))
    slantPath.addLineToPoint( CGPoint(x: rect.width - slantDelta, y: 0))
    slantPath.addLineToPoint( CGPoint(x: rect.width,              y: rect.height))
    slantPath.addLineToPoint( CGPoint(x: 0,                       y: rect.height))
    slantPath.closePath()
    
    slantLayer.path = slantPath.CGPath
    
    self.layer.mask = slantLayer
  }
  
}
