//
//  InterstitialProvider.swift
//  AdProvider
//
//  Created by Itamar Nakar on 29/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol InterstitialProviderProtocol : AdProviderProtocol
{
    func willBeginRetrieveAd()
    func adWillDismissScreen()
}

class InterstitialProvider : NSObject
{
    var interstitial        : DFPInterstitial
    let adUnit              : String
    let customParams        : AdCustomParams?
    let rootViewController  : UIViewController?
    weak var delegate       : InterstitialProviderProtocol?
    
    init(with adUnit : String,
         customParams: AdCustomParams?,
         rootViewController : UIViewController,
         andDelegate delegate : InterstitialProviderProtocol)
    {
        self.interstitial       = DFPInterstitial(adUnitID: adUnit)
        self.adUnit             = adUnit
        self.customParams       = customParams
        self.rootViewController = rootViewController
        self.delegate           = delegate
        
        super.init()
        
        provideIntrstitial()
    }
    
    func provideIntrstitial()
    {
        // Bla Bla according to shouldShowAd()
        if shouldShowInterstitial()
        {
            delegate?.willBeginRetrieveAd()
            
            let request = DFPRequest()
            interstitial.load(request)
            interstitial.delegate = self
        }
    }
}

//MARK - Private Method

extension InterstitialProvider
{
    private func shouldShowInterstitial() -> Bool
    {
        let retValue = AdsConfiguration.shouldShowAd(by: AppCounter.shared.interstitialAdsCount.getCurrentCount(),
                                                     configuration: UserInSession.shared.interstitialConfiguration)
        AppCounter.shared.interstitialAdsCount.increseCounter()
        return retValue
    }
}


//MARK - GADInterstitialDelegate

extension InterstitialProvider : GADInterstitialDelegate
{
    //MARK - Ad Request Lifecycle Notifications
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        /// Called when an interstitial ad request succeeded. Show it at the next transition point in your
        /// application such as when transitioning between view controllers.
        
        if ad.isReady {
            delegate?.adProvider(didFinishWith: .interstitial(ad))
            
        } else {
            print(">>>Ad wasn't ready")
            delegate?.adWillDismissScreen()
        }
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        /// Called when an interstitial ad request completed without an interstitial to
        /// show. This is common since interstitials are shown sparingly to users.
        delegate?.adWillDismissScreen()
    }
    
    //MARK - Display-Time Lifecycle Notifications
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        /// Called just before presenting an interstitial. After this method finishes the interstitial will
        /// animate onto the screen. Use this opportunity to stop animations and save the state of your
        /// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
        /// Store from a link on the interstitial).
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self]
            in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.adWillDismissScreen()
        }
        
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        /// Called when |ad| fails to present.
        delegate?.adWillDismissScreen()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        /// Called before the interstitial is to be animated off the screen.
        delegate?.adWillDismissScreen()
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        /// Called just after dismissing an interstitial and it has animated off the screen.
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        /// Called just before the application will background or terminate because the user clicked on an
        /// ad that will launch another application (such as the App Store). The normal
        /// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
        /// before this.
    }
}

