//
//  SeatsSectionPickerView.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 14.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

enum SectionPosition: Int {
  case None
  case TopLeft, BottomLeft
  case TopMiddle, BottomMiddle
  case TopRight, BottomRight
  
  var seatsPrice: Int {
    
    switch self {
    case .None:
      return 0
    case .TopLeft, .TopRight:
      return 3
    case .BottomLeft, .BottomRight:
      return 4
    case .TopMiddle:
      return 9
    case .BottomMiddle:
      return 8
    }
    
  }
}

protocol SeatsSectionPickerViewDelegate: NSObjectProtocol {
  
  func seatsSectionSelected(selectedSection: SectionPosition, withPositionButton: UIButton!)
  
}

final class SeatsSectionPickerView: UIView {
  
  @IBOutlet private var sectionButtons: [UIButton]!
  
  weak var delegate: SeatsSectionPickerViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    for button in sectionButtons {
      button.layer.cornerRadius = Constants.defaultViewLayerCornerRadius
      button.backgroundColor = Constants.Colors.DarkRed.getColor()
      button.addTarget(self, action: "sectionSelected:", forControlEvents: .TouchUpInside)
    }
  }
  
  func sectionSelected(sender: UIButton!) {
    let sectionPosition = getSectionPositionFromButton(sender)
    delegate?.seatsSectionSelected(sectionPosition, withPositionButton: sender)
  }
  
  
  private func getSectionPositionFromButton(button: UIButton) -> SectionPosition {
    guard let buttonIndex = sectionButtons.indexOf(button) else {
      return .None
    }
    
    guard let sectionPosition = SectionPosition(rawValue: buttonIndex + 1) else {
      return .None
    }
    
    return sectionPosition
  }
  
}
