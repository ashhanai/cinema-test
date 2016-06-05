//
//  MovieReducer.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import Foundation
import ReSwift

struct MovieReducer: Reducer {
  
  func handleAction(var state: AppState, action: Action) -> AppState {
    
    let movieAction = action as! MovieActions
    
    switch movieAction {
    
      case .MovieActionSelect(let movieIndex):
        state.selectedMovie = state.movies[movieIndex]
        
      case .MovieShowtimeSelect(let showtime):
        state.selectedMovieShowtime = showtime
      
      case .MovieSeatsSectionSelected(let movieSection):
        state.selectedMovieSeatsSection = movieSection
      
      case .MovieSeatsSelected(let selectedSeats):
        state.selectedMovieSeats = selectedSeats
      
      case .MovieOrderConfirmed:
        state.selectedMovie             = nil
        state.selectedMovieShowtime     = nil
        state.selectedMovieSeatsSection = .None
        state.selectedMovieSeats        = 0
        
    }
    
    return state
    
  }
  
}