//
//  MovieCellExtensionTransitionAnimator.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 24.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

protocol MovieCellExtensionTransitionAnimatorDelegate : NSObjectProtocol {
  
  func getOriginFrame() -> CGRect
  func getSelectedMovieCell() -> UICollectionViewCell!
  
}

final class MovieCellExtensionTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration    = Constants.defaultTransitionDuration
  var presenting  = true
  var originFrame: CGRect {
    return delegate?.getOriginFrame() ?? CGRect.zero
  }
  var selectedMovieCell: UICollectionViewCell? {
    return delegate?.getSelectedMovieCell()
  }
  
  weak var delegate: MovieCellExtensionTransitionAnimatorDelegate?
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView()!
    
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    let moviePickerVC = (presenting ? fromVC : transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!) as! MoviePickerVC
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let showtimeView = (presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!) as! ShowtimePickerView
    
    // VC view transform
    
    let initialFrame = presenting ? originFrame : showtimeView.frame
    let finalFrame = presenting ? showtimeView.frame : originFrame
    
    let xScaleFactor = originFrame.width / showtimeView.frame.width
    let yScaleFactor = originFrame.height / showtimeView.frame.height
    
    let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
    
    
    // Movie view transform
    
    let movieViewYPositingTransform = CGAffineTransformMakeTranslation(0, 26)
    let movieScaleTransform = CGAffineTransformInvert(scaleTransform)
    let movieViewTransfrom = CGAffineTransformConcat(movieScaleTransform, movieViewYPositingTransform)
    
    
    // Before presenting setup
    
    if presenting {
      showtimeView.transform = scaleTransform
      showtimeView.center = CGPoint(
        x: initialFrame.midX,
        y: initialFrame.midY)
      showtimeView.clipsToBounds = true
      
      showtimeView.movieView.transform = movieViewTransfrom
      showtimeView.movieMetadata.alpha = 0
    }
    
    showtimeView.backgroundColor = UIColor.clearColor()
    
    for cell in moviePickerVC.myView.moviesCollectionView.visibleCells() {
      cell.alpha = presenting ? 1 : 0
    }
    
    selectedMovieCell?.hidden = true
    
    showtimeView.playImage.alpha = presenting ? 0 : 1
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(showtimeView)
    
    
    // Animating
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      
      // Showtime view
      
      showtimeView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
      showtimeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      
      
      // Showtime movie view
      
      showtimeView.movieView.transform = self.presenting ? CGAffineTransformIdentity : movieViewTransfrom
      showtimeView.movieMetadata.alpha = self.presenting ? 1 : 0
      showtimeView.playImage.alpha = self.presenting ? 1 : 0
      
    }) { (_) -> Void in
      self.selectedMovieCell?.hidden = false
      showtimeView.backgroundColor = Constants.Colors.BackgroundPink.getColor()
      transitionContext.completeTransition(true)
    }
    
    UIView.animateWithDuration(duration/4) { () -> Void in
      
      for cell in moviePickerVC.myView.moviesCollectionView.visibleCells() {
        cell.alpha = self.presenting ? 0 : 1
        cell.transform = self.presenting ? CGAffineTransformMakeScale(0.5, 0.5) : CGAffineTransformIdentity
      }
      
    }
    
    let round = CABasicAnimation(keyPath: "cornerRadius")
    round.fromValue = presenting ? 4/xScaleFactor : 0.0
    round.toValue = presenting ? 0.0 : 4/xScaleFactor
    round.duration = duration / 2
    showtimeView.layer.addAnimation(round, forKey: nil)
    showtimeView.layer.cornerRadius = presenting ? 0.0 : 4/xScaleFactor
    
  }
  
}