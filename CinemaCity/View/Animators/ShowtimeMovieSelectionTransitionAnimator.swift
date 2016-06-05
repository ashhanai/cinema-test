//
//  ShowtimeMovieSelectionTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 26.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class ShowtimeMovieSelectionTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration    = Constants.defaultTransitionDuration
  var presenting  = true
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    // Get views from context
    
    let containerView = transitionContext.containerView()!
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    let loadingSeatsView = (presenting ? toView : fromView) as! LoadingSeatsView
    let showtimePickerView = (presenting ? fromView : toView) as! ShowtimePickerView
    
    
    // Prepare view transformations
    
    let cinemaScreenTransform = CGAffineTransformMakeTranslation(0, -30)
    let seatsViewTransform = CGAffineTransformMakeTranslation(0, -60)
    
    let showtimePickerTransform = CGAffineTransformMakeTranslation(0, 60)
    let showtimeMoviePictureTransform
      = CGAffineTransformMakeScale(1, loadingSeatsView.cinemaScreenView.bounds.height/showtimePickerView.movieView.bounds.height)
    
    if presenting {
      loadingSeatsView.cinemaScreenView.transform = cinemaScreenTransform
      loadingSeatsView.seatsView.transform = seatsViewTransform
      loadingSeatsView.seatsView.alpha = 0
      loadingSeatsView.cinemaScreenView.alpha = 0
      
      loadingSeatsView.loadingView.startAnimation()
    }
    
    loadingSeatsView.loadingView.alpha = presenting ? 0 : 1
    loadingSeatsView.backgroundColor = UIColor.clearColor()
    showtimePickerView.showtimeDateView.layer.cornerRadius = 4
    showtimePickerView.showtimeCollectionView.layer.cornerRadius = 4
    
    
    
    // Add view to container
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(loadingSeatsView)
    
    
    // Animate
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      
        loadingSeatsView.cinemaScreenView.transform
          = self.presenting ? CGAffineTransformIdentity : cinemaScreenTransform
        loadingSeatsView.seatsView.transform
          = self.presenting ? CGAffineTransformIdentity : seatsViewTransform
        
        showtimePickerView.showtimeDateView.transform
          = self.presenting ? showtimePickerTransform : CGAffineTransformIdentity
        showtimePickerView.movieView.transform
          = self.presenting ? showtimeMoviePictureTransform : CGAffineTransformIdentity
      
        loadingSeatsView.seatsView.alpha = self.presenting ? 1 : 0
        
      }) { (_) -> Void in
        transitionContext.completeTransition(true)
        showtimePickerView.showtimeDateView.layer.cornerRadius = 0
        showtimePickerView.showtimeCollectionView.layer.cornerRadius = 0
        loadingSeatsView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
    }
    
    let delay = presenting ? 0 : duration*3/4
    UIView.animateWithDuration(duration/4, delay: delay, options: .CurveEaseIn, animations: {
      () -> Void in
      
        loadingSeatsView.cinemaScreenView.alpha = self.presenting ? 1 : 0
        loadingSeatsView.loadingView.alpha = self.presenting ? 1 : 0
      
      }, completion: nil)
    
  }
  
}