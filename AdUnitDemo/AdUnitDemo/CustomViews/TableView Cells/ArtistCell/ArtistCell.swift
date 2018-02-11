//
//  ArtistCell.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    //MARK: - Oulets
    
    @IBOutlet weak var songLengthLable: UILabel!
    @IBOutlet weak var songNameLable: UILabel!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
}

extension ArtistCell: CellInfoable {}

