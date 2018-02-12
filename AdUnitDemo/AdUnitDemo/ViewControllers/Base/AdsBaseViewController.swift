//
//  AdsBaseViewController.swift
//  AdProvider
//
//  Created by Itamar Nakar on 29/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdsBaseViewController: UIViewController
{
    // typealias
    typealias bannerBoolDictionary = Dictionary<GADBannerView, Bool>
    
    var adSlpashView         : AdSplashView!
    var adProvider           : BannerAdProvider?
    var interstitialProvider : InterstitialProvider?
    let bannerAdContainerView = UIView.init(frame:CGRect(x: 0,
                                                         y: 0,
                                                         width: UIScreen.main.bounds.width,
                                                         height: 50))
    
    // Table Ads manegement Properties
    var asdToLoad       = [DFPBannerView]()
    var loadStateForAds = [GADBannerView : Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBottomView(bannerAdContainerView)
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
    func addBannerViewToContainerView(_ bannerView: GADBannerView)
    {
        bannerAdContainerView.subviews.forEach({ $0.removeFromSuperview() })
        bannerAdContainerView.addBottomView(bannerView)
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
            
        case .regular(let bannerView) :
            addBannerViewToContainerView(bannerView)
            print("Banner Ad Have been Received")
            
        case .interstitial(let ad):
            ad.present(fromRootViewController: self)
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
