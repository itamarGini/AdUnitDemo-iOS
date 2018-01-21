//
//  TableController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 21/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

protocol TableController: UITableViewDelegate, UITableViewDataSource
{
    //  MARK: - Methods
    func registerReuseIdentifiers(forTableView tableView: UITableView)
}

