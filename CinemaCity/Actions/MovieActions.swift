//
//  MovieActions.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import Foundation
import ReSwift

enum MovieActions: Action {
  case MovieActionSelect(movieIndex: Int)
  case MovieShowtimeSelect(showtime: Showtime)
  case MovieSeatsSectionSelected(movieSection: SectionPosition)
  case MovieSeatsSelected(seatsSelected: Int)
  case MovieOrderConfirmed
}