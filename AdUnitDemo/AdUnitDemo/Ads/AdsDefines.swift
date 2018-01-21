//
//  AdsDefines.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 27/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

struct Ads
{
    static var heightRatio  = UIScreen.main.bounds.height / 568 // Base Height is iPhone SE (= 568)
    
    enum AdsType
    {
        case interstitial
        case bannerSticky
        case banner100
        case liveBox
        case inbox
        case nativeAd
        case articleBottomAd
    }
    
    enum AdProviderResultEnum
    {
        case regular(GADBannerView)
        case interstitial(GADInterstitial)
        case tablewView(UIView?,IndexPath?)
    }
    
    enum ComponentsType : String {
        case person             = "person"
        case bannerAppAdunit    = "banner_app_adunit"
        case nativeAdsAdunit    = "native_ads_adunit"
    }
    
}
