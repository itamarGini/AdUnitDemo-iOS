//
//  UserInSession.swift
//  AdUnitDemo
//
//  Created by Itamar on 08/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation
import Firebase

class UserInSession
{
    static let shared = UserInSession()
    
    // MARK: - Property
    private (set) var interstitialConfiguration   : AdsConfiguration!
    private       var googleTagManagerHelper      : GoogleTagManagerHelper
    private       var container                   : TAGContainer!

    // MARK: - Computed property
    var gtmContainer: TAGContainer!
    {
        return container
    }
    
    // MARK: - Object life cycle
    private init()
    {
        googleTagManagerHelper = GoogleTagManagerHelper()
    }
    
    // MARK: - Method
    func configure()
    {
        FirebaseApp.configure()
        googleTagManagerHelper.initiateGoogleTagManager()
        googleTagManagerHelper.delegate = self
        
        /* Interstitial Hardcoded configuration for Testing */
        interstitialConfiguration = AdsConfiguration(shouldShowFirstAd: true,adInterval: 1, shouldAdRepeat: true)
    }
}


// MARK: - GoogleTagManagerHelperDelegate
extension UserInSession : GoogleTagManagerHelperDelegate
{
    func gtmContainer(_ gtmContainer: TAGContainer!) {
        container = gtmContainer
        print(">>>\(container.string(forKey: "is_gtm_active")!)")
    }
    func defaultContainer(_ gtmContainer: TAGContainer!) {
        container = gtmContainer
        print(">>>defaultContainer:\(container.string(forKey: "is_gtm_active"))")
    }
}
