//
//  PersonCellGenerator.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

internal struct PersonCellGenerator : TableCellGeneratorProtocol {
    
    // MARK: - Protocol methods
    static func cell(for indexPath: IndexPath, inTableVIew tableView: UITableView) -> UITableViewCell
    {
        return tableView.dequeueReusableCell(withIdentifier: PersonCell.cellID, for: indexPath)
    }
    
    static func registerReuseIdentifier(for tableView: UITableView)
    {
        tableView.register(PersonCell.cellNib, forCellReuseIdentifier: PersonCell.cellID)
    }
    
    static func configure(cell: UITableViewCell, by object: Any)
    {
        guard let metaData = object as? MultiItemMetaData else { return }
        guard let cell = cell as? PersonCell else { return }
        
        cell.songNameLable.text     = metaData.title
        cell.songLengthLable.text   = metaData.subTitle
    }
}

