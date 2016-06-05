//
//  NavigationController.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController {
  
  private let movieCellExtensionTransitionAnimator = MovieCellExtensionTransitionAnimator()
  private let showtimeMovieSelectionTransitionAnimator = ShowtimeMovieSelectionTransitionAnimator()
  private let selectSeatsSectionTransitionAnimator = SelectSeatsSectionTransitionAnimator()
  private let selectSeatsTransitionAnimator = SelectSeatsTransitionAnimator()
  private let reviewOrderTransitionAnimator = ReviewOrderTransitionAnimator()
  private let orderConfirmedTransitionAnimator = OrderConfirmedTransitionAnimator()
  
  var movieCellExtensionTransitionAnimatorDelegate: MovieCellExtensionTransitionAnimatorDelegate? {
    get { return movieCellExtensionTransitionAnimator.delegate }
    set { movieCellExtensionTransitionAnimator.delegate = newValue }
  }
  var selectSeatsTransitionAnimatorDelegate: SelectSeatsTransitionAnimatorDelegate? {
    get { return selectSeatsTransitionAnimator.delegate }
    set { selectSeatsTransitionAnimator.delegate = newValue }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBar.opaque = false
    self.navigationBar.translucent = true
    self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationBar.shadowImage = UIImage()
    self.delegate = self
    
  }

}

extension NavigationController : UINavigationControllerDelegate {
  
  func navigationController(navigationController: UINavigationController,
    animationControllerForOperation operation: UINavigationControllerOperation,
    fromViewController fromVC: UIViewController,
    toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      
      let presenting = operation == .Push
      if (toVC is ShowtimePickerVC && presenting) || (fromVC is ShowtimePickerVC && !presenting) {
        
        if !presenting {
          (toVC as! MoviePickerVC).animateMovieCells = false
        }
        
        movieCellExtensionTransitionAnimator.presenting = presenting
        return movieCellExtensionTransitionAnimator
        
      } else if (toVC is LoadingSeatsVC && presenting) || (fromVC is LoadingSeatsVC && !presenting) {
        
        showtimeMovieSelectionTransitionAnimator.presenting = presenting
        return showtimeMovieSelectionTransitionAnimator
        
      } else if (toVC is SelectSeatsSectionVC && presenting) || (fromVC is SelectSeatsSectionVC && !presenting) {
        
        selectSeatsSectionTransitionAnimator.presenting = presenting
        selectSeatsSectionTransitionAnimator.navigationController = navigationController
        return selectSeatsSectionTransitionAnimator
        
      } else if (toVC is SelectSeatsVC && presenting) || (fromVC is SelectSeatsVC && !presenting) {
        
        selectSeatsTransitionAnimator.presenting = presenting
        return selectSeatsTransitionAnimator
        
      } else if (toVC is ReviewOrderVC && presenting) || (fromVC is ReviewOrderVC && !presenting) {
        
        if toVC is SelectSeatsVC || fromVC is SelectSeatsVC {
          
          reviewOrderTransitionAnimator.presenting = presenting
          return reviewOrderTransitionAnimator
          
        } else if toVC is MoviePickerVC {
          
          (toVC as! MoviePickerVC).animateMovieCells = true
          return orderConfirmedTransitionAnimator
          
        }
        
      }
      
      return nil
  }
  
}
