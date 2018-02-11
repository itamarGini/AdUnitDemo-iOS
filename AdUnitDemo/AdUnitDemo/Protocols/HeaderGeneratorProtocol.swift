//
//  HeaderGeneratorProtocol.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 05/02/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

protocol HeaderGeneratorProtocol
{
    static func generateHeader(for tableView: UITableView, with metaData: HeaderMetaData?, andWidth: CGFloat) -> UIView?
}

