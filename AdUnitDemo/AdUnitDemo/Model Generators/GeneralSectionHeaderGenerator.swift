//
//  GeneralSectionHeaderGenerator.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 05/02/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

import UIKit

class GeneralSectionHeaderGenerator: HeaderGeneratorProtocol
{
    static func generateHeader(for tableView: UITableView, with metaData: HeaderMetaData?, andWidth width: CGFloat) -> UIView?
    {
        guard let headerMetaData = metaData             else { return nil }
        guard let title          = headerMetaData.title else { return nil }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.headerFooterViewID) as? SectionHeaderView else { return nil }
        
        header.titleLabel.text   = title

        return header
    }
}
