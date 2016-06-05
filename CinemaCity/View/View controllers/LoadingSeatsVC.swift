//
//  LoadingSeatsVC.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 26.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift
import AVFoundation
import NVActivityIndicatorView
import SnapKit

final class LoadingSeatsView : UIView {
  
  @IBOutlet weak var cinemaScreenView: CinemaScreenView!
  @IBOutlet weak var seatsView: UIView! {
    didSet {
      seatsView.backgroundColor     = Constants.Colors.DarkGray.getColor()
      seatsView.layer.cornerRadius  = Constants.defaultViewLayerCornerRadius
    }
  }
  
  @IBOutlet weak var movieName: UILabel!
  @IBOutlet weak var movieShowtime: UILabel!
  
  @IBOutlet weak var loadingIndicatorContainer: UIView!
  
  weak var loadingView: NVActivityIndicatorView!
}

final class LoadingSeatsVC: ViewController, StoreSubscriber {
  
  var myView : LoadingSeatsView! {
    return self.view as! LoadingSeatsView
  }
  
  var movie: Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupView()
    
    self.navigationBarTitle = "loading seats"
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "loadingEnded:", userInfo: nil, repeats: false)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  
  func newState(state: HasSelectedMovieShowtimeState) {
    movie = state.selectedMovie
    
    myView.movieName.text = movie?.name.uppercaseString ?? "Unknown"
    myView.movieShowtime.text = state.selectedMovieShowtime ?? "--:--"
  }
  
  func loadingEnded(timer: NSTimer) {
    let selectSeatsSectionVC: SelectSeatsSectionVC = UIStoryboard.storyboard(.Main).instantiateViewController()
    self.navigationController?.pushViewController(selectSeatsSectionVC, animated: true)
  }
  
  private func setupView() {
    
    let movieURL = NSBundle.mainBundle().URLForResource("hate8", withExtension: "mp4")!
    let playerItem = AVPlayerItem(URL: movieURL)
    
    let player = AVPlayer(playerItem: playerItem)
    
    if myView.cinemaScreenView.playerLayer == nil {
      myView.cinemaScreenView.playerLayer = AVPlayerLayer(player: player)
      myView.cinemaScreenView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }
    
    player.play()
    player.muted = true
    
    let loadingView = NVActivityIndicatorView(frame: CGRect.zero, type: .BallBeat, color: UIColor.lightGrayColor(), size: CGSize(width: 40, height: 40))
    myView.loadingIndicatorContainer.addSubview(loadingView)
    loadingView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(myView.loadingIndicatorContainer)
    }
    
    myView.loadingView = loadingView
    
  }

}
