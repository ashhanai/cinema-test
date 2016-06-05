//
//  SelectSeatsSectionTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 14.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

final class SelectSeatsSectionTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration    = Constants.defaultTransitionDuration
  var presenting  = true
  
  let cinemaScreenRotatinoAngle = CGFloat(M_PI_2 * 0.8)
  weak var navigationController: UINavigationController?
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    // Get views from cotext
    
    let containerView = transitionContext.containerView()!
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    let selectSeatsSectionView = (presenting ? toView : fromView) as! SelectSeatsSectionView
    let loadingSeatsView = (presenting ? fromView : toView) as! LoadingSeatsView
    
    selectSeatsSectionView.cinemaScreenView.playerLayer = loadingSeatsView.cinemaScreenView.playerLayer
    
    
    // Prepare view transformations
    
    var identity = CATransform3DIdentity
    identity.m34 = 1 / 500
    
    let xOffset = selectSeatsSectionView.cinemaScreenView.bounds.height / 4
    
    var cinemaScreenTransform = CATransform3DTranslate(identity, 1, -xOffset, 1)
    cinemaScreenTransform = CATransform3DScale(cinemaScreenTransform, 0.7, 0.7, 1)
    cinemaScreenTransform = CATransform3DRotate(cinemaScreenTransform, cinemaScreenRotatinoAngle, 1, 0, 0)
    
    var seatsSectionsTransform = CATransform3DTranslate(identity, 0, xOffset * 2, 0)
    seatsSectionsTransform = CATransform3DScale(seatsSectionsTransform, 1.7, 1.7, 1)
    seatsSectionsTransform = CATransform3DRotate(seatsSectionsTransform, -CGFloat(M_PI_2), 1, 0, 0)
    
    
    // Prepare vies for animation
    
    selectSeatsSectionView.cinemaScreenView.layer.transform = presenting ? CATransform3DIdentity : cinemaScreenTransform
    selectSeatsSectionView.seatSectionsView.layer.transform = presenting ? seatsSectionsTransform : CATransform3DIdentity
    selectSeatsSectionView.seatSectionsView.alpha = presenting ? 0 : 1
    selectSeatsSectionView.backgroundColor = UIColor.clearColor()
    
    loadingSeatsView.loadingView.alpha = presenting ? 1 : 0
    loadingSeatsView.cinemaScreenView.hidden = true
    
    
    // Add view to container
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(selectSeatsSectionView)
    
    
    // Animation
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      
      selectSeatsSectionView.cinemaScreenView.layer.transform =
        self.presenting ? cinemaScreenTransform : CATransform3DIdentity
      selectSeatsSectionView.seatSectionsView.layer.transform =
        self.presenting ? CATransform3DIdentity : seatsSectionsTransform
      selectSeatsSectionView.seatSectionsView.alpha = self.presenting ? 1 : 0
      
      loadingSeatsView.loadingView.alpha = self.presenting ? 0 : 1
      
      }) { (_) -> Void in
        selectSeatsSectionView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
        loadingSeatsView.cinemaScreenView.hidden = false
        transitionContext.completeTransition(true)
        if !self.presenting {
          loadingSeatsView.cinemaScreenView.playerLayer = selectSeatsSectionView.cinemaScreenView.playerLayer
          self.navigationController?.popViewControllerAnimated(true)
        }
      }
    
  }
  
}
