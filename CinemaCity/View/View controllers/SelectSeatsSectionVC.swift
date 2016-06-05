//
//  SelectSeatsSectionVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 08.02.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift
import AVFoundation

final class SelectSeatsSectionView: UIView {
  
  @IBOutlet weak var movieInfoView    : MovieInfoView!
  @IBOutlet weak var cinemaScreenView : CinemaScreenView!
  @IBOutlet weak var seatSectionsView : SeatsSectionPickerView!
  
}

final class SelectSeatsSectionVC: ViewController, StoreSubscriber {
  
  var myView: SelectSeatsSectionView! {
    return self.view as! SelectSeatsSectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myView.seatSectionsView.delegate = self
    
    self.navigationBarTitle = "select seats"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  
  func newState(state: HasSelectedMovieShowtimeState) {
    let movie = state.selectedMovie
    
    myView.movieInfoView.name = movie?.name.uppercaseString ?? "Unknown"
    myView.movieInfoView.showtime = state.selectedMovieShowtime ?? "--:--"
  }
  
}

extension SelectSeatsSectionVC: SeatsSectionPickerViewDelegate {
  
  func seatsSectionSelected(selectedSection: SectionPosition, withPositionButton: UIButton!) {
    
    mainStore.dispatch(
      MovieActions.MovieSeatsSectionSelected(movieSection: selectedSection)
    )
    
    let selectSeatsVC: SelectSeatsVC = UIStoryboard.storyboard(.Main).instantiateViewController()
    self.navigationController?.pushViewController(selectSeatsVC, animated: true)
    
  }
  
}