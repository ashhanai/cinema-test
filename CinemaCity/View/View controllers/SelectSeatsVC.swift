//
//  SelectSeatsVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift
import ChameleonFramework

final class SelectSeatsView: UIView {
  
  @IBOutlet weak var cinemaScreenView : CinemaScreenView!
  @IBOutlet weak var seatsView        : SeatsView!
  @IBOutlet weak var movieInfoView    : MovieInfoView!
  
}

final class SelectSeatsVC: ViewController, StoreSubscriber {
  
  var myView: SelectSeatsView! {
    return self.view as! SelectSeatsView
  }
  
  var sectionPosition: SectionPosition!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    (self.navigationController as? NavigationController)?.selectSeatsTransitionAnimatorDelegate = self
    
    self.navigationBarTitle = "number of seats"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  @IBAction func seatSelected(sender: UIButton) {
    guard let buttonIndex = myView.seatsView.seatButtons.indexOf(sender) else {
      return
    }
    
    mainStore.dispatch(
      MovieActions.MovieSeatsSelected(seatsSelected: buttonIndex + 1)
    )
    
    let reviewOrderVC: ReviewOrderVC = UIStoryboard.storyboard(.Main).instantiateViewController()
    self.navigationController?.pushViewController(reviewOrderVC, animated: true)
  }
  
  
  func newState(state: HasSelectedMovieSectionState) {
    let movie = state.selectedMovie
    
    myView.movieInfoView.name = movie?.name.uppercaseString ?? "Unknown"
    myView.movieInfoView.showtime = state.selectedMovieShowtime ?? "--:--"
    myView.movieInfoView.section = state.selectedMovieSeatsSection.rawValue
    
    sectionPosition = state.selectedMovieSeatsSection
  }
  
}

extension SelectSeatsVC: SelectSeatsTransitionAnimatorDelegate {
  
  func getCinemaScreenSight() -> CinemaScreenSight {
    
    switch sectionPosition! {
      
    case .TopLeft, .BottomLeft:
      return .Right
    case .TopMiddle, .BottomMiddle:
      return .Middle
    case .TopRight, .BottomRight:
      return .Left
      
    case .None:
      fatalError("Sectin has to be selected") // FIXME: Add 
      
    }
    
  }
  
}
