//
//  Movie.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 20.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

protocol MovieShortcut {
  var name: String { get }
  var picture: UIImage! { get }
}

struct Movie: MovieShortcut {
  
  var name: String
  var picture: UIImage!
  
  let director: String?
  let duration: Int? // Number of minutes
  
  var showtimes: [DayShowtimes] = [
    DayShowtimes(date: "SUN, JAN 10", times: ["10:00", "12:00", "14:00", "16:00"]),
    DayShowtimes(date: "MON, JAN 11", times: ["10:00", "12:00", "14:00", "16:00"]),
    DayShowtimes(date: "THU, JAN 12", times: ["10:00", "12:00", "14:00", "16:00"]),
    DayShowtimes(date: "WED, JAN 13", times: ["10:00", "12:00", "14:00", "16:00"]),
    DayShowtimes(date: "THU, JAN 14", times: ["10:00", "12:00", "14:00", "16:00"])
  ]
  
  init(name: String, pictureName: String, director: String? = nil, duration: Int? = nil) {
    self.name     = name
    self.picture  = UIImage(named: pictureName)
    self.director = director
    self.duration = duration
  }
  
  mutating func setShowtimes(showtimes: [DayShowtimes]) {
    self.showtimes = showtimes
  }
  
}

struct DayShowtimes {
  
  let date: String
  var times: [String]
  
  init(date: String, times: [String]) {
    self.date = date
    self.times = times
  }
  
}

typealias Showtime = String