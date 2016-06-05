//
//  MoviePickerVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift

final class MoviePickerView: UIView {
  
  @IBOutlet weak var moviesCollectionView: UICollectionView! {
    didSet {
      moviesCollectionView.registerNib(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
      moviesCollectionView.backgroundColor = UIColor.clearColor()
      moviesCollectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
  }
  
}

final class MoviePickerVC: ViewController, StoreSubscriber {
  
  // MARK: Property
  
  var myView: MoviePickerView! {
    return self.view as! MoviePickerView
  }
  
  var moviesDataSource = [Movie]()
  
  var transitionOriginFrame = CGRectZero
  var transitionMovieCell: UICollectionViewCell!
  
  var animateMovieCells = true
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    (self.navigationController as? NavigationController)?.movieCellExtensionTransitionAnimatorDelegate = self
    
    myView.moviesCollectionView.dataSource = self
    myView.moviesCollectionView.delegate = self
    
    self.navigationBarTitle = "playing today"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if !animateMovieCells { return }
    
    let cells = self.myView.moviesCollectionView.visibleCells()
    let movieCollectionViewHeight = myView.moviesCollectionView.bounds.height
    
    for cell in cells {
      cell.transform = CGAffineTransformMakeTranslation(0, movieCollectionViewHeight)
      cell.alpha = 0
    }
    
    for (index, cell) in cells.enumerate() {
      
      UIView.animateWithDuration(1,
        delay: Double(index) * 0.2,
        options: [.CurveEaseOut],
        animations: { () -> Void in
        
        cell.transform = CGAffineTransformIdentity
        cell.alpha = 1
        
        }, completion: nil)
      
    }
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  
  func newState(state: HasMovieListState) {
    self.moviesDataSource = state.movies
  }
  
  // MARK: Actions
  // MARK: Selectors
  // MARK: Private
  
  private func updatedMovies(newMovieState: [Movie]) {
    
    if moviesDataSource.isEmpty {
      
//      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//        
//        // Add all movies to collection view with time gap
//        
//        for (index, movie) in newMovieState.enumerate() {
//          
//          dispatch_async(dispatch_get_main_queue()) {
//            self.moviesDataSource.append(movie)
//            self.myView.moviesCollectionView.insertItemsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)])
//          }
//          
//          usleep(100000)
//        }
//        
//      }
      
    }
    
  }
  
}

extension MoviePickerVC : UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return moviesDataSource.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell: MovieCollectionCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
    
    cell.movieShortcut = self.moviesDataSource[indexPath.row]
    
    return cell
  }
  
}

extension MoviePickerVC : UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    mainStore.dispatch(
      MovieActions.MovieActionSelect(movieIndex: indexPath.row)
    )
    
    let cell = collectionView.cellForItemAtIndexPath(indexPath)
    
    transitionOriginFrame = cell!.superview!.convertRect(cell!.frame, toView: nil)
    transitionMovieCell = cell
    
    let showtimePickerVC: ShowtimePickerVC = UIStoryboard.storyboard(.Main).instantiateViewController()
    self.navigationController?.pushViewController(showtimePickerVC, animated: true)
  }
  
}

extension MoviePickerVC : MovieCellExtensionTransitionAnimatorDelegate {
  
  func getOriginFrame() -> CGRect {
    return transitionOriginFrame
  }
  
  func getSelectedMovieCell() -> UICollectionViewCell! {
    return transitionMovieCell
  }
  
}

