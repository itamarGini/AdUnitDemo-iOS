//
//  DataController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import Foundation

protocol DataController
{
    // MARK: - Method
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func object(for indexPath: IndexPath) -> Any?
    func didSelectObject(inIndexPath indexPath: IndexPath)
    
    func header(for section: Int) -> HeaderMetaData?
    func type(of section: Int)    -> Ads.ComponentsType
}
