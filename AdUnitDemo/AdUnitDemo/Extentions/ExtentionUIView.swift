//
//  ExtentionUIView.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

extension UIView
{
    func addBottomView(_ newSubview: UIView)
    {
        newSubview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(newSubview)
        self.addConstraints(
            [NSLayoutConstraint(item: newSubview,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: self.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: newSubview,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: self,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}
