//
//  Component.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation


protocol Component
{
    var name          : String                  {get}
    var items         : [CategoryItemMetaData]?  {get}
    var headerMetaData: HeaderMetaData?         {get}
    var componentType : Ads.ComponentsType      {get}
    
    static func generate(from dictionary: [String:Any]?) -> Component?
    static func generateItem(from object: [String : Any], and componentType: Ads.ComponentsType) -> CategoryItemMetaData?
}

extension Component
{
    //We overload this method so the defaultValues won't be mandatory (inside a factory method)
    static func generate(from dictionary: [String:Any]?) -> Component?
    {
        return generate(from: dictionary)
    }
    
    static func generateItemsDataArray(from dictionary: [String:Any]?, withKey key: String = "items", and type: Ads.ComponentsType) -> [CategoryItemMetaData]
    {
        var itemsArray   =  [CategoryItemMetaData]()
        
        guard let arrayOfItems = dictionary?[key] as? [[String : Any]] else { return itemsArray }
        
        for (_,object) in arrayOfItems.enumerated()
        {
            guard let categoryItemMetaData = generateItem(from: object, and: type) else { continue }

            itemsArray.append(categoryItemMetaData)
        }
        
        return itemsArray
    }
}
