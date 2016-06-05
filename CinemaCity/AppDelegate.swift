//
//  AppDelegate.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit
import ReSwift

var mainStore = MainStore(reducer: CombinedReducer([MovieReducer()]), state: AppState())


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

}

