//
//  CellInfoable.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

protocol CellInfoable : NSObjectProtocol
{
    static var cellID  : String { get }
    static var cellNib : UINib  { get }
}

extension CellInfoable
{
    static var cellID  : String
    {
        return String(describing: Self.self)
    }
    
    static var cellNib : UINib
    {
        return UINib(nibName: cellID, bundle: nil)
    }
}
