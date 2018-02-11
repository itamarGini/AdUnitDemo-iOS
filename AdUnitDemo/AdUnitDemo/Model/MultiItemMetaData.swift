//
//  MultiItemMetaData.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

struct MultiItemMetaData: CategoryItemMetaData
{
    var componentType    : Ads.ComponentsType
    let title            : String
    let subTitle         : String
    let songURL          : String
    
    init(title: String,
         subTitle: String,
         songURL : String,
         componentType: Ads.ComponentsType)
    {
        self.componentType     = componentType
        self.title             = title
        self.subTitle          = subTitle
        self.songURL           = songURL
    }
}

extension MultiItemMetaData
{
    init(with dictionary: [String : Any]?,
         andType componentType: Ads.ComponentsType)
    {
        enum generatorKeys: String
        {
            case title             = "song_name"
            case subTitle          = "song_length"
            case songURL           = "song_url"
        }
        self.title             = dictionary?[generatorKeys.title.rawValue]    as? String ?? ""
        self.subTitle          = dictionary?[generatorKeys.subTitle.rawValue] as? String ?? ""
        self.songURL           = dictionary?[generatorKeys.songURL.rawValue] as? String ?? ""
        self.componentType     = componentType
    }
}
