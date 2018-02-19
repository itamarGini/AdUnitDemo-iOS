//
//  AdCellGenerator.swift
//  AdUnitDemo
//
//  Created by Itamar on 14/02/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

internal struct AdCellGenerator : TableCellGeneratorProtocol {
    
    // MARK: - Protocol methods
    static func cell(for indexPath: IndexPath, inTableVIew tableView: UITableView) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellID, for: indexPath)
        return cell
    }
    
    static func registerReuseIdentifier(for tableView: UITableView)
    {
        tableView.register(BannerCell.cellNib, forCellReuseIdentifier: BannerCell.cellID)
    }
    
    static func configure(cell: UITableViewCell, by object: Any)
    {
        guard let metaData = object as? MultiItemMetaData else { return }
        guard let cell = cell as? BannerCell else { return }
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
//TODO:
//        cell.contentView.addSubview(metaData.BennerView)
//        metaData.BennerView.center = cell.contentView.center
    }
}
