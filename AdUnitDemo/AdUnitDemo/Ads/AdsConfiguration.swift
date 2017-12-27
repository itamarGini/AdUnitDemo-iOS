//
//  AdsConfiguration.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation

struct AdsConfiguration {
    // use configuration params
    private var shouldShowFirstAd : Bool = true
    private var adInterval        : Int  = 1
    private var shouldAdRepeat    : Bool = true
    
    init(shouldShowFirstAd: Bool, adInterval: Int, shouldAdRepeat : Bool)
    {
        self.shouldShowFirstAd  = shouldShowFirstAd
        self.adInterval         = adInterval
        self.shouldAdRepeat     = shouldAdRepeat
    }
}

extension AdsConfiguration
{
    static func shouldShowAd(by currentAdsCount : Int, configuration : AdsConfiguration?) -> Bool
    {
        guard let configuration = configuration else { print("No Configuration Has Been Provided"); return false }
        
        switch currentAdsCount
        {
        case 0:  return configuration.shouldShowFirstAd ? true : false
        case configuration.adInterval:  return true
        default: return configuration.shouldAdRepeat && (currentAdsCount % configuration.adInterval) == 0 ? true : false
        }
    }
}
