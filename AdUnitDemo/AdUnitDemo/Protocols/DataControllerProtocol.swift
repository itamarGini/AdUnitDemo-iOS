//
//  DataControllerProtocol.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

protocol DataControllerDelegate: class
{
    func dataControllerWillBeginUpdateData()
    func dataControllerDidFinishUpdateData(_ dataController: DataController,with error: Error?)
    func dataController(_ dataController: DataController, didSelectItem item:SegueType, atIndexPath indexPath:IndexPath?)
    func dataController(_ dataController: DataController, reloadSectionAt index: Int)
}
