//
//  HeaderFooterViewInfoable.swift
//  Ynet
//
//  Created by ido meirov on 27/09/2017.
//  Copyright © 2017 Gini-Apps. All rights reserved.
//

import UIKit

protocol HeaderFooterViewInfoable
{
    static var headerFooterViewID  : String { get }
    static var headerFooterViewNib : UINib  { get }

}

extension HeaderFooterViewInfoable
{
    static var headerFooterViewID  : String
    {
        return String(describing: Self.self)
    }
    
    static var headerFooterViewNib : UINib
    {
        return UINib(nibName: headerFooterViewID, bundle: nil)
    }
}
