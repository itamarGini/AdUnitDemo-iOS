//
//  AdsTableViewController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 16/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

class AdsTableViewController: AdsBaseViewController {

    var tableController          : AdsTableController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableController = AdsTableController(withDelegate: self)
        setup()
    }
    
    func setup()
    {
        tableController?.registerReuseIdentifiers(forTableView: tableView)
        tableView.dataSource                   = tableController
        tableView.delegate                     = tableController
    }
    
    func preloadNextAd()
    {
//        tableController.dataController.
    }
}

private extension AdsTableViewController
{
    
}

extension AdsTableViewController : DataControllerDelegate
{
    @objc func dataControllerWillBeginUpdateData(){}
    
    func dataControllerDidFinishUpdateData(_ dataController: DataController,with error: Error?)
    {
        
        tableView.reloadData()
    }

    func dataController(_ dataController: DataController, didSelectItem segueType: SegueType, atIndexPath indexPath: IndexPath?)
    {
        //handle(segueType)
    }
    
    func dataController(_ dataController: DataController, reloadSectionAt index: Int)
    {
      //  reload(tableView, at: index)
    }
}
