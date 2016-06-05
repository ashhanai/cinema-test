//
//  SelectSeatsTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

enum CinemaScreenSight: Int {
  case Left = -1
  case Middle = 0
  case Right = 1
}

protocol SelectSeatsTransitionAnimatorDelegate: NSObjectProtocol {
  
  func getCinemaScreenSight() -> CinemaScreenSight
  
}

final class SelectSeatsTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = Constants.defaultTransitionDuration
  var presenting = true
  let cinemaScreenSightPositionOffset = (UIScreen.mainScreen().bounds.width / 3) + 10
  
  weak var delegate: SelectSeatsTransitionAnimatorDelegate?
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    // Get views from cotext
    
    let containerView = transitionContext.containerView()!
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    let selectSeatsView = (presenting ? toView : fromView) as! SelectSeatsView
    let selectSeatsSectionView = (presenting ? fromView : toView) as! SelectSeatsSectionView
    
    
    // Prepare view transformations
    
    guard let cinemaScreenSight = delegate?.getCinemaScreenSight() else {
      fatalError("Delegate has to return cinema screen sight")
    }
    
    var indentity = CATransform3DIdentity
    indentity.m34 = 1 / 500
    
    var cinemaScreenTransform = CATransform3DScale(indentity, 1.5, 1.5, 1)
    cinemaScreenTransform
      = CATransform3DTranslate(cinemaScreenTransform, CGFloat(cinemaScreenSight.rawValue) * cinemaScreenSightPositionOffset, 30, 0)
    
    let selectSeatsSeatsTransform
      = CGAffineTransformMakeTranslation(CGFloat(cinemaScreenSight.rawValue) * 20, 0)
    
    // Prepare view for transition
    
    selectSeatsView.cinemaScreenView.playerLayer = selectSeatsSectionView.cinemaScreenView.playerLayer
    
    if presenting {
      selectSeatsView.cinemaScreenView.layer.transform = selectSeatsSectionView.cinemaScreenView.layer.transform
    }
    
    selectSeatsSectionView.seatSectionsView.alpha = presenting ? 1 : 0
    
    selectSeatsView.movieInfoView.sectionLabel.alpha = presenting ? 0 : 1
    selectSeatsView.backgroundColor = UIColor.clearColor()
    selectSeatsView.seatsView.alpha = presenting ? 0 : 1
    selectSeatsView.seatsView.layer.transform = CATransform3DMakeTranslation(1, 1, 150)
    
    selectSeatsView.seatsView.seatsFloorView.transform = selectSeatsSeatsTransform
    selectSeatsView.seatsView.seatsFloorFrontView.transform = selectSeatsSeatsTransform
    
    
    // Add view to container
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(selectSeatsView)
    
    selectSeatsSectionView.cinemaScreenView.hidden = true
    
    // Animate transition
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      
      selectSeatsView.seatsView.alpha = self.presenting ? 1 : 0
      selectSeatsView.movieInfoView.sectionLabel.alpha = self.presenting ? 1 : 0
      selectSeatsView.cinemaScreenView.layer.transform
        = self.presenting ? cinemaScreenTransform : selectSeatsSectionView.cinemaScreenView.layer.transform
      
      selectSeatsSectionView.seatSectionsView.alpha = self.presenting ? 0 : 1
      
      }) { (_) -> Void in
        
        selectSeatsView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
        
        if !self.presenting {
          selectSeatsSectionView.cinemaScreenView.hidden = false
          selectSeatsSectionView.cinemaScreenView.playerLayer = selectSeatsView.cinemaScreenView.playerLayer
        }
        
        transitionContext.completeTransition(true)
        
    }
    
  }
  
}