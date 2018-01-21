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
        case Ads.ComponentsType.person.rawValue          : object = PersonMetaData.self
        case Ads.ComponentsType.bannerAppAdunit.rawValue    : object = BannerAppAdunitMetaData.self
        case Ads.ComponentsType.nativeAdsAdunit.rawValue    : object = NativeAdsAdunitMetaData.self

        default: break
        }
        
        return object?.generate(from: component)
    }
}
