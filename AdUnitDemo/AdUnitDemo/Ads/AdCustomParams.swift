//
//  AdCustomParams.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 02/11/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation

struct AdCustomParams
{
    let articleId   : String?
    let dcPath      : String?
    let descriptionUrl : String?
    let isGpsEnabled   : String = "FALSE"
    let appVersion     : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    init(with articleId : String? = nil,
         dcPath         : String?,
         descriptionUrl : String?)
    {
        self.articleId = articleId
        self.dcPath = dcPath
        self.descriptionUrl = descriptionUrl
    }
}

