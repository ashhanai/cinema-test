//
//  ViewController.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = Constants.Colors.BackgroundPink.getColor()
  }
  
  var navigationBarTitle: String! {
    didSet {
      self.setAttributedNavigationItemTitle(navigationBarTitle)
    }
  }
  
  func popNavigationController() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  private func setAttributedNavigationItemTitle(title: String) {
    
    var words = title.componentsSeparatedByString(" ")
    let lastWord = words.removeLast()
    let thinTitle = words.reduce("") { $0 + " " + $1 }
    
    let titleColor = Constants.Colors.DarkGray.getColor()
    
    let attributedTitle = NSMutableAttributedString(
      string: thinTitle.uppercaseString,
      attributes: [
        NSForegroundColorAttributeName: titleColor,
        NSFontAttributeName: UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
      ])
    attributedTitle
      .appendAttributedString(NSAttributedString(
        string: " " + lastWord.uppercaseString,
        attributes: [
          NSForegroundColorAttributeName: titleColor,
          NSFontAttributeName: UIFont.systemFontOfSize(16, weight: UIFontWeightHeavy)
        ]))
    
    let customTitleView = UILabel()
    customTitleView.attributedText = attributedTitle
    customTitleView.sizeToFit()
    
    self.navigationItem.titleView = customTitleView
  }
}

