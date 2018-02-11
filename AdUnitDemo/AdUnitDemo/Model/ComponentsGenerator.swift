//
//  ComponentsGenerator.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/01/2018.
//  Copyright © 2018 Ads. All rights reserved.
//

import Foundation

class ComponentsGenerator
{
    static func generateComponent(from component: [String:Any]?) -> Component?
    {
        let name   = "name"
        guard let component = component                           else { return nil }
        guard let componentName      = component[name] as? String else { return nil }
        var object: Component.Type?
        
        switch componentName
        {
        case Ads.ComponentsType.artist.rawValue          : object = ArtistMetaData.self
        case Ads.ComponentsType.bannerAppAdunit.rawValue,
             Ads.ComponentsType.nativeAdsAdunit.rawValue : object = BannerAppAdunitMetaData.self

        default: break
        }
        
        return object?.generate(from: component)
    }
}
