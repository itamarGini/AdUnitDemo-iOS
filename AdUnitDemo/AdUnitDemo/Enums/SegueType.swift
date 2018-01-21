//
//  SegueType.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

enum SegueType
{
    case item(String)
    case adItem(String)
    
    var segueName: String
    {
        switch self
        {
        case .item(_)   : return Segues.item.rawValue
        case .adItem(_) : return Segues.adItem.rawValue            
        }
    }
}

enum Segues: String
{
    case item   = "segueToItem"
    case adItem = "segueToAdItem"
}
