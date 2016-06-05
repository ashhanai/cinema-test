//
//  ReviewOrderVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift

final class ReviewOrderView: UIView {
  
  @IBOutlet var grayViews: [UIView]! {
    didSet {
      for grayView in grayViews {
        
        grayView.layer.cornerRadius = Constants.defaultViewLayerCornerRadius
        grayView.clipsToBounds = true
        grayView.backgroundColor = Constants.Colors.DarkGray.getColor()
        
      }
    }
  }
  
  @IBOutlet weak var nameGrayView: UIView!
  @IBOutlet weak var infoGrayView: UIView!
  @IBOutlet weak var totalGrayView: UIView!
  
  @IBOutlet weak var movieNameLabel: UILabel!
  
  @IBOutlet weak var movieDateLabel: UILabel!
  @IBOutlet weak var movieShowtimeLabel: UILabel!
  @IBOutlet weak var movieSectionLabel: UILabel!
  @IBOutlet weak var movieSeatsLabel: UILabel!
  @IBOutlet weak var totalPriceLabel: UILabel!
  
  @IBOutlet weak var staticTotalLabel: UILabel!
  @IBOutlet weak var staticTouchIDLabel: UILabel!
  
}

final class ReviewOrderVC: ViewController, StoreSubscriber {
  
  var myView: ReviewOrderView! {
    return self.view as! ReviewOrderView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBarTitle = "review order"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  
  func newState(state: HasSelectedMovieSeatsSatet) {
    
    myView.movieNameLabel.text = (state.selectedMovie?.name ?? "Unknown").uppercaseString
//    myView.movieDateLabel.text = ""
    myView.movieShowtimeLabel.text = state.selectedMovieShowtime
    myView.movieSectionLabel.text = "section".uppercaseString + " \(state.selectedMovieSeatsSection.rawValue)"
    myView.movieSeatsLabel.text = "\(state.selectedMovieSeats) " + "seats".uppercaseString
    
    myView.totalPriceLabel.text = "$\(state.selectedMovieSeats * state.selectedMovieSeatsSection.seatsPrice)"
  }
  
  
  @IBAction func confirmOrder(sender: AnyObject) {
    
    mainStore.dispatch(
      MovieActions.MovieOrderConfirmed
    )
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
}