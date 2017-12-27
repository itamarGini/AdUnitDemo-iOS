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
}
