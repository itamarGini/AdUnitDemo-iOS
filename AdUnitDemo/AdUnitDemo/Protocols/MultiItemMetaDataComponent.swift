//
//  MultiItemMetaDataComponent.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

protocol MultiItemMetaDataComponent: Component
{
    
}

extension MultiItemMetaDataComponent
{
    static func generateItem(from object: [String : Any], and type: Ads.ComponentsType) -> CategoryItemMetaData?
    {
        return MultiItemMetaData(with: object, andType: type)
    }
}

