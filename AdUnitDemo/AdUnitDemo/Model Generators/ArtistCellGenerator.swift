//
//  ArtistCellGenerator.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

internal struct ArtistCellGenerator : TableCellGeneratorProtocol {
    
    // MARK: - Protocol methods
    static func cell(for indexPath: IndexPath, inTableVIew tableView: UITableView) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.cellID, for: indexPath)
        return cell
    }
    
    static func registerReuseIdentifier(for tableView: UITableView)
    {
        tableView.register(ArtistCell.cellNib, forCellReuseIdentifier: ArtistCell.cellID)
    }
    
    static func configure(cell: UITableViewCell, by object: Any)
    {
        guard let metaData = object as? MultiItemMetaData else { return }
        guard let cell = cell as? ArtistCell else { return }
        
        cell.songNameLable.text     = metaData.title
        cell.songLengthLable.text   = metaData.subTitle
    }
}

