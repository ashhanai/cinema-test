//
//  ShowtimePickerVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 19.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift

final class ShowtimePickerView : UIView {
  
  @IBOutlet weak var movieView           : UIView! {
    didSet {
      movieView.layer.cornerRadius = 4
      movieView.backgroundColor = Constants.Colors.DarkGray.getColor()
    }
  }
  @IBOutlet weak var showtimeView        : UIView! {
    didSet {
      showtimeView.layer.cornerRadius = 4
      showtimeDateView.backgroundColor = Constants.Colors.DarkGray.getColor()
    }
  }
  
  @IBOutlet weak var playImage           : UIImageView!
  
  @IBOutlet weak var moviePictureView    : UIImageView!
  @IBOutlet weak var movieName           : UILabel!
  @IBOutlet weak var movieMetadata       : UILabel!
  
  @IBOutlet weak var showtimePickerLabel : UILabel!
  @IBOutlet weak var showtimeDateButton  : UIButton!
  @IBOutlet weak var showtimeDateView    : UIView!
  
  @IBOutlet weak var showtimeCollectionView : UICollectionView! {
    didSet {
      showtimeCollectionView.backgroundColor = Constants.Colors.DarkRed.getColor()
    }
  }
}

final class ShowtimePickerVC : ViewController, StoreSubscriber {
  
  var myView: ShowtimePickerView! {
    return self.view as! ShowtimePickerView
  }
  
  var movie: Movie?
  var showtimeDayIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myView.showtimeCollectionView.dataSource = self
    myView.showtimeCollectionView.delegate = self
    
    automaticallyAdjustsScrollViewInsets = false
    
    self.navigationBarTitle = "playing today"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  func newState(state: AppState) {
    movie = state.selectedMovie
    updateMovie(movie)
  }
  
  private func updateMovie(movie: Movie?) {
    myView.moviePictureView.image = movie?.picture
    myView.movieName.text = movie?.name.uppercaseString
    myView.movieMetadata.text = (movie?.duration?.timeString ?? "0") + " - " + (movie?.director ?? "Unknown")
    myView.showtimeCollectionView.reloadData()
  }
  
}

extension ShowtimePickerVC : UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movie?.showtimes[showtimeDayIndex].times.count ?? 0
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell: ShowtimeCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
    
    cell.showtime = movie!.showtimes[showtimeDayIndex].times[indexPath.row]
    
    return cell
  }
  
}

extension ShowtimePickerVC : UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    mainStore.dispatch(
      MovieActions.MovieShowtimeSelect(showtime: movie!.showtimes[showtimeDayIndex].times[indexPath.row])
    )
    
    let loadingSeatsVC: LoadingSeatsVC = UIStoryboard.storyboard(.Main).instantiateViewController()
    self.navigationController?.pushViewController(loadingSeatsVC, animated: true)
  }
  
}
