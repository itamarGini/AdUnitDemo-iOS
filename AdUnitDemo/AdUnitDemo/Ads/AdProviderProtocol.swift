//
//  AdProviderProtocol.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 27/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation

protocol AdProviderProtocol : class
{
    func adProvider(didFinishWith result : Ads.AdProviderResultEnum )
}
