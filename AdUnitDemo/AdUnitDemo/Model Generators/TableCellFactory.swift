//
//  TableCellFactory.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

struct TableCellFactory
{
    static func cell(for object: Any?, with indexPath: IndexPath, atTableVIew tableView: UITableView) -> UITableViewCell
    {
        var generator: TableCellGeneratorProtocol.Type?
        
        if let object = object as? CategoryItemMetaData
        {
            switch object.componentType
            {
            case .person             : generator = PersonCellGenerator.self
            default                 : break
            }
        }
        
        guard let cell = generator?.cell(for: indexPath, inTableVIew: tableView) else { return UITableViewCell() }
        if let object = object
        {
            generator?.configure(cell: cell, by: object)
        }
        return cell
    }
    
    static func heightForRow(for object: Any?, with indexPath: IndexPath) -> CGFloat
    {
        let personHeightMultiplier       : CGFloat = 0.3
        
        let screenWidth = UIScreen.main.bounds.width
        var height      : CGFloat = 0
        
        if let object = object as? CategoryItemMetaData
        {
            switch object.componentType
            {
            case .person     : height = screenWidth * personHeightMultiplier
            default                 : height = 50
            }
        }
        return height
    }
    
    static func registerReuseIdentifiers(for tableView: UITableView)
    {
        PersonCellGenerator.registerReuseIdentifier(for: tableView)
    }
}

