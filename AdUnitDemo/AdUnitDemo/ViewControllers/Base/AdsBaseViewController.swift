//
//  AdsBaseViewController.swift
//  AdProvider
//
//  Created by Itamar Nakar on 29/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdsBaseViewController: UIViewController {
    
    var adSlpashView         : AdSplashView!
    var adProvider           : BannerAdProvider?
    var interstitialProvider : InterstitialProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adSlpashView = AdSplashView(frame: view.bounds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Private Helpers
extension AdsBaseViewController
{
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}

extension AdsBaseViewController : AdProviderProtocol
{
    func adProvider(didFinishWith result: Ads.AdProviderResultEnum)
    {
        switch result
        {
        case .tablewView :
            //TODO: implemet table insertion
            print("implemet table insertion")
            
        case .regular(let bannerView) : addBannerViewToView(bannerView)
            print("Banner Ad Have been Received")
            
        case .interstitial(let ad): ad.present(fromRootViewController: self)
            print("Interstitial Have been Received")
        }
    }
}

extension AdsBaseViewController : InterstitialProviderProtocol
{
    func willBeginRetrieveAd() {
        // Present Splash
        guard let mainWindow = UIApplication.shared.mainWindow() else { return }
        mainWindow.addSubview(adSlpashView)
    }
    
    func adWillDismissScreen() {
        // Remove splash
        adSlpashView.removeFromSuperview()
    }
}

extension AdsBaseViewController : BannerAdProviderProtocol
{
    func didFailToReceiveAd(_ adProvider: BannerAdProvider)
    {
        print("Did Fail To Receive Ad")
    }
}
