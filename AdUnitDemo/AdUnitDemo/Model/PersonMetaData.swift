//
//  Person.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation
//person
struct PersonMetaData
{
    var name          : String
    var title         : String!
    let items         : [CategoryItemMetaData]?
    let headerMetaData: HeaderMetaData?
    let componentType : Ads.ComponentsType = .person
}

extension PersonMetaData: MultiItemMetaDataComponent
{    
    static func generate(from dictionary: [String:Any]?) -> Component?
    {
        enum generatorKeys: String
        {
            case name   = "name"
            case title   = "title"
        }
        
        guard let dictionary  = dictionary else { return nil }
        let name   = dictionary[generatorKeys.name.rawValue] as? String ?? ""
        let title  = dictionary[generatorKeys.title.rawValue] as? String ?? ""
        let items  = generateItemsDataArray(from: dictionary, and: Ads.ComponentsType.person)
        let header = HeaderMetaData(with: dictionary)
        
        return PersonMetaData(name: name, title: title, items : items, headerMetaData : header)
    }
}
