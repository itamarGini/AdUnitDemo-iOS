//
//  AdsTableController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

class AdsTableController: NSObject
{
    // MARK: - Properties
    var  dataController: DataController!
    
    // MARK: - Initializers
    init(withDelegate delegate: DataControllerDelegate)
    {
        super.init()
        dataController = getDataController(withDelegate: delegate)
    }
    
    func getDataController(withDelegate delegate: DataControllerDelegate) -> AdsDataController
    {
        return AdsDataController(withDelegate: delegate)
    }
}

//  MARK: - ChannelTableController Implementation
extension AdsTableController: TableController
{
    func registerReuseIdentifiers(forTableView tableView: UITableView)
    {
        TableCellFactory.registerReuseIdentifiers(for: tableView)
    }
}

//  MARK: - UITableViewDataSource Implementation
extension AdsTableController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return dataController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataController.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let object = dataController.object(for: indexPath)
        return TableCellFactory.cell(for: object, with: indexPath, atTableVIew: tableView)
    }
}

//  MARK: - UITableViewDelegate Implementation
extension AdsTableController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
//        let headerMetaData = dataController.header(for: section)
//        return HeaderSectionFactory.heightForHeader(with: headerMetaData)
        return 30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let object = dataController.object(for: indexPath)
        return TableCellFactory.heightForRow(for: object, with: indexPath)
    }
}
