//
//  AdCounter.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 20/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation

class AppCounter
{
    static let shared = AppCounter()
    
    var interstitialAdsCount = Counter()
    var vifeoFeedAdsCount    = Counter()
}

struct Counter
{
    private var count = 0
    
    mutating func increseCounter()
    {
        count = count + 1
    }
    
    func getCurrentCount() -> Int
    {
        return count
    }
    
    mutating func resetCounter()
    {
        count = 0
    }
}
