//
//  UIKit+.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 30.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

extension UIColor {
  
  class func colorFromHEX(hex: String, andAlpha alpha: CGFloat = 1.0) -> UIColor {
    var cString = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString as NSString
    
    if (cString.hasPrefix("#")) {
      cString = cString.substringFromIndex(1)
    }
    
    if (cString.length != 6) {
      return UIColor.grayColor()
    }
    
    let rString = cString.substringToIndex(2)
    let gString = (cString.substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = (cString.substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string:rString).scanHexInt(&r)
    NSScanner(string:gString).scanHexInt(&g)
    NSScanner(string:bString).scanHexInt(&b)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1)).colorWithAlphaComponent(alpha)
  }
  
}

extension UIStoryboard {
  
  enum Storyboard: String {
    case Main
  }
  
  static func storyboard(storyboard: Storyboard, bundle: NSBundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>() -> T {
    let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
    
    guard let viewController = optionalViewController as? T  else {
      fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier)")
    }
    
    return viewController
  }
  
}

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(self)
  }
}

extension StoryboardIdentifiable where Self: UICollectionViewCell {
  static var storyboardIdentifier: String {
    return String(self)
  }
}

extension UIViewController : StoryboardIdentifiable {}
extension UICollectionViewCell : StoryboardIdentifiable {}

extension UICollectionView {
  
  func dequeueReusableCellForIndexPath<T: UICollectionViewCell where T: StoryboardIdentifiable>(indexPath: NSIndexPath) -> T {
    let optionalCell = self.dequeueReusableCellWithReuseIdentifier(T.storyboardIdentifier, forIndexPath: indexPath)
    
    guard let cell = optionalCell as? T else {
      fatalError("Couldn’t instantiate collection view cell with identifier \(T.storyboardIdentifier)")
    }
    
    return cell
  }
  
}


