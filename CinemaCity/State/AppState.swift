//
//  AppState.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import Foundation
import ReSwift

protocol HasMovieListState {
  var movies: [Movie] { get }
}

protocol HasSelectedMovieState {
  var selectedMovie: Movie? { get }
}

protocol HasSelectedMovieShowtimeState : HasSelectedMovieState {
  var selectedMovieShowtime: Showtime! { get }
}

protocol HasSelectedMovieSectionState : HasSelectedMovieShowtimeState {
  var selectedMovieSeatsSection: SectionPosition { get }
}

protocol HasSelectedMovieSeatsSatet: HasSelectedMovieSectionState {
  var selectedMovieSeats: Int { get }
}

struct AppState: StateType, HasMovieListState, HasSelectedMovieSeatsSatet {
  
  var movies: [Movie] = [
    Movie(name: "the hateful eight", pictureName: "hate-8", director: "Tarantino", duration: 155),
    Movie(name: "the martian", pictureName: "the-martian", director: "Scott", duration: 120),
    Movie(name: "point break", pictureName: "point-break", director: "Core", duration: 114),
    Movie(name: "furious 7", pictureName: "furious-7", director: "Wan", duration: 137)
  ]
  
  var selectedMovie: Movie?
  var selectedMovieShowtime: Showtime!
  var selectedMovieSeatsSection: SectionPosition = .None
  var selectedMovieSeats: Int = 0
  
}
