//
//  HeaderSectionFactory.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 05/02/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

struct HeaderSectionFactory
{
    static func header(for tableView: UITableView, object: HeaderMetaData?, withSectionType type: Ads.ComponentsType, andWidth width: CGFloat) -> UIView?
    {
        guard let object = object else { return nil }
        
        var generator: HeaderGeneratorProtocol.Type?
        
        switch type
        {
        case .none     : return nil
        default        : generator = GeneralSectionHeaderGenerator.self
        }
        
        let headerView = generator?.generateHeader(for: tableView, with: object, andWidth: width)
        
        return headerView
    }
    
    static func heightForHeader(with headerMetaData: HeaderMetaData?) -> CGFloat
    {
        guard let _ = headerMetaData?.title else { return 50 }
        return 50
    }
    
    static func registerHeaderFooterViewReuseIdentifier(for tableView: UITableView)
    {
        tableView.register(SectionHeaderView.headerFooterViewNib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.headerFooterViewID)
    }
}

