//
//  BannerAppAdunit.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

// banner_app_adunit
struct BannerAppAdunitMetaData: AdComponentMetaData
{
    var name          : String
    var link          : String
    let image         : String
    let imageWidth    : Int
    let imageHeight   : Int
    let items         : [CategoryItemMetaData]?
    let headerMetaData: HeaderMetaData?    = nil
    let componentType : Ads.ComponentsType = .bannerAppAdunit
}

extension BannerAppAdunitMetaData: MultiItemMetaDataComponent
{
    static func generate(from dictionary: [String:Any]?) -> Component?
    {
        enum generatorKeys: String
        {
            case name        = "name"
            case link        = "link_ip"
            case image       = "img_ip_640x150"
            case imageWidth  = "img_ip_width"
            case imageHeight = "img_ip_height"
        }
        
        guard let dictionary  = dictionary else { return nil }
        let name              = dictionary[generatorKeys.name.rawValue]        as? String ?? ""
        let link              = dictionary[generatorKeys.link.rawValue]        as? String ?? ""
        let image             = dictionary[generatorKeys.image.rawValue]       as? String ?? ""
        let imageWidth        = dictionary[generatorKeys.imageWidth.rawValue]  as? Int    ?? 0
        let imageHeight       = dictionary[generatorKeys.imageHeight.rawValue] as? Int    ?? 0
        
        let item = MultiItemMetaData(title: "BannerAppComponent",
                                     subTitle: "",
                                     componentType: .bannerAppAdunit)
        
        return BannerAppAdunitMetaData(name: name,
                                          link: link,
                                          image: image,
                                          imageWidth: imageWidth,
                                          imageHeight: imageHeight,
                                          items: [item])
    }
}
