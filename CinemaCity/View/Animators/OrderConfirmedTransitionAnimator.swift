//
//  OrderConfirmedTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class OrderConfirmedTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = Constants.defaultTransitionDuration
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    // Get views from cotext
    
    let containerView = transitionContext.containerView()!
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    let reviewOrderView = fromView as! ReviewOrderView
    let moviePickerView = toView as! MoviePickerView
    
    moviePickerView.backgroundColor = nil
    
    // Add view to container
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(moviePickerView)
    
    
    // Animate transition
    
    UIView.animateWithDuration(duration - 0.2, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
      reviewOrderView.totalGrayView.transform = CGAffineTransformMakeScale(0.5, 0.5)
      reviewOrderView.totalGrayView.alpha = 0
      }, completion: nil)
    
    UIView.animateWithDuration(duration - 0.2, delay: 0.1, options: .CurveEaseOut, animations: { () -> Void in
      reviewOrderView.infoGrayView.transform = CGAffineTransformMakeScale(0.5, 0.5)
      reviewOrderView.infoGrayView.alpha = 0
      }, completion: nil)
    
    UIView.animateWithDuration(duration - 0.2, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
      reviewOrderView.nameGrayView.transform = CGAffineTransformMakeScale(0.5, 0.5)
      reviewOrderView.nameGrayView.alpha = 0
      }) { (_) -> Void in
        
        moviePickerView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
        
        transitionContext.completeTransition(true)
    }
    
  }
  
}
