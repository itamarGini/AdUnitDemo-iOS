//
//  AdProvider.swift
//  AdProvide
//
//  Created by Itamar Nakar on 29/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol BannerAdProviderProtocol : AdProviderProtocol
{
    func didFailToReceiveAd(_ adProvider: BannerAdProvider)
}

class BannerAdProvider: NSObject
{
    var bannerView          : DFPBannerView?
    let adType              : Ads.AdsType
    let adUnit              : String
    let customParams        : AdCustomParams?
    let rootViewController  : UIViewController?
    weak var delegate       : BannerAdProviderProtocol?
    
    init(with adUnit : String,
         type : Ads.AdsType,
         customParams: AdCustomParams?,
         rootViewController : UIViewController,
         andDelegate delegate : BannerAdProviderProtocol)
    {
        self.bannerView         = DFPBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        self.adType             = type
        self.adUnit             = adUnit
        self.customParams       = customParams
        self.rootViewController = rootViewController
        self.delegate           = delegate
        
        super.init()
        
        provideAd()
    }
    
    func provideAd()
    {
        // DFP Ad - build and request
        guard let bannerView = bannerView else { return }
        
        let adSizes : [NSValue]
        switch adType {
        case .bannerSticky:
            adSizes = [NSValueFromGADAdSize(kGADAdSizeBanner),
                       NSValueFromGADAdSize(kGADAdSizeSmartBannerPortrait),
                       NSValueFromGADAdSize(kGADAdSizeLargeBanner)]
        default:
            adSizes = [NSValueFromGADAdSize(kGADAdSizeBanner)]
            break
        }
        
        bannerView.validAdSizes = adSizes
        bannerView.adUnitID     = adUnit
        bannerView.rootViewController = rootViewController
        bannerView.delegate = self
        
        bannerView.load(DFPRequest())
    }
}

//MARK: - GADBannerViewDelegate
extension BannerAdProvider : GADBannerViewDelegate
{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView)
    {        
        delegate?.adProvider(didFinishWith: .regular(bannerView))
        print(">>> adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError)
    {
        delegate?.didFailToReceiveAd(self)
        print(">>> adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}
