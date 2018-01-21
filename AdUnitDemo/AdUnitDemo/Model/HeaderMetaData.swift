//
//  HeaderMetaData.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

struct HeaderMetaData
{
    //MARK: - Properties
    let title     : String?

    
    //MARK: - Constructor
    init(with dictionary: [String: Any]?)
    {
        enum keys: String
        {
            case title          = "title"
            case categoryName   = "cat_name"
        }
        
        self.title = dictionary?[keys.title.rawValue] as? String ?? dictionary?[keys.categoryName.rawValue] as? String
    }
}
