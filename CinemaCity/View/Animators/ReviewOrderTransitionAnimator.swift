//
//  ReviewOrderTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 19.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class ReviewOrderTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = Constants.defaultTransitionDuration
  var presenting = true
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    // Get views from cotext
    
    let containerView = transitionContext.containerView()!
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    let reviewOrderView = (presenting ? toView : fromView) as! ReviewOrderView
    let selectSeatsView = (presenting ? fromView : toView) as! SelectSeatsView
    
    
    // Prepare view transformations
    
    let selectSeatsCinemaViewPresentingTransform = CATransform3DScale(selectSeatsView.cinemaScreenView.layer.transform, 0.8, 0.8, 1)
    let selectSeatsCinemaViewNotPresentingTransform = CATransform3DScale(selectSeatsView.cinemaScreenView.layer.transform, 1.2, 1.2, 1)
    
    let selectSeatsSeatsViewTransform = CGAffineTransformMakeScale(0.8, 0.8)
    
    
    let nameGrayViewTransform
      = CGAffineTransformMakeTranslation(0, selectSeatsView.movieInfoView.frame.origin.y - reviewOrderView.nameGrayView.frame.origin.y - (presenting ? 44 : 0))  // FIXME: Remove 44 for navigation bar
    let infoGrayViewTransform
    = CGAffineTransformMakeTranslation(0, selectSeatsView.movieInfoView.frame.origin.y - reviewOrderView.infoGrayView.frame.origin.y - (presenting ? 44 : 0))  // FIXME: Remove 44 for navigation bar
    let totalGrayViewTranform
      = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.height - reviewOrderView.totalGrayView.frame.origin.y)
    
    
    // Prepare view for transition
    
    if presenting {
      
      reviewOrderView.nameGrayView.transform = nameGrayViewTransform
      reviewOrderView.infoGrayView.transform = infoGrayViewTransform
      reviewOrderView.totalGrayView.transform = totalGrayViewTranform
      
      selectSeatsView.movieInfoView.alpha = 0
      
    } else {
      
      selectSeatsView.cinemaScreenView.layer.transform = selectSeatsCinemaViewPresentingTransform
      selectSeatsView.seatsView.transform = selectSeatsSeatsViewTransform
      
    }
    
    selectSeatsView.cinemaScreenView.alpha = presenting ? 1 : 0
    selectSeatsView.seatsView.alpha = presenting ? 1 : 0
    
    reviewOrderView.backgroundColor = UIColor.clearColor()
    
    
    // Add view to container
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(reviewOrderView)
    
    
    // Animate transition
    
    UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
      
      selectSeatsView.cinemaScreenView.layer.transform = self.presenting ? selectSeatsCinemaViewPresentingTransform : selectSeatsCinemaViewNotPresentingTransform
      selectSeatsView.seatsView.transform = self.presenting ? selectSeatsSeatsViewTransform : CGAffineTransformIdentity
      
      selectSeatsView.cinemaScreenView.alpha = self.presenting ? 0 : 1
      selectSeatsView.seatsView.alpha = self.presenting ? 0 : 1
      
      
      reviewOrderView.nameGrayView.transform = self.presenting ? CGAffineTransformIdentity : nameGrayViewTransform
      reviewOrderView.infoGrayView.transform = self.presenting ? CGAffineTransformIdentity : infoGrayViewTransform
      reviewOrderView.totalGrayView.transform = self.presenting ? CGAffineTransformIdentity : totalGrayViewTranform
      
      }) { (_) -> Void in
        
        reviewOrderView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
        
        if !self.presenting {
          selectSeatsView.movieInfoView.alpha = 1
        }
        
        transitionContext.completeTransition(true)
    }
    
  }
  
}