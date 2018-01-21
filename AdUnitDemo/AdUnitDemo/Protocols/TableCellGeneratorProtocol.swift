//
//  TableCellGeneratorProtocol.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

protocol TableCellGeneratorProtocol
{
    //MARK: - Methods
    static func cell(for indexPath: IndexPath, inTableVIew tableView: UITableView) -> UITableViewCell
    static func registerReuseIdentifier(for tableView: UITableView)
    static func configure(cell: UITableViewCell, by object: Any)
}
