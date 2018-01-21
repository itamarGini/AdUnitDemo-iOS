//
//  NativeAdsAdunit.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

struct NativeAdsAdunitMetaData : AdComponentMetaData
{
    var name          : String
    var link          : String
    let items         : [CategoryItemMetaData]? = nil
    let headerMetaData: HeaderMetaData?      = nil
    let componentType : Ads.ComponentsType = .nativeAdsAdunit
}

extension NativeAdsAdunitMetaData: MultiItemMetaDataComponent
{    
    static func generate(from dictionary: [String:Any]?) -> Component?
    {
        enum generatorKeys: String
        {
            case name   = "name"
            case link   = "link_ip"
        }
        
        guard let dictionary  = dictionary else { return nil }
        let name  = dictionary[generatorKeys.name.rawValue] as? String ?? ""
        let link  = dictionary[generatorKeys.link.rawValue] as? String ?? ""
        return NativeAdsAdunitMetaData(name: name, link: link)
    }
}

//native_ads_adunit
