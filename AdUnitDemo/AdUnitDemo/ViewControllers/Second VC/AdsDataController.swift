//
//  AdsDataController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit

class AdsDataController: NSObject
{
    typealias fetchDictionary = Dictionary<String, AnyObject>
    
    //MARK: - Private members
    private weak var delegate : DataControllerDelegate?
    private var items = [Component]()
    
    //  MARK: - Initializers
    init(withDelegate delegate: DataControllerDelegate?)
    {
        super.init()
        
        self.delegate           = delegate
        self.fetchData()
    }
    
    func fetchData() {
        if let path = Bundle.main.path(forResource: "AdsJsonFile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? fetchDictionary, let components = jsonResult["components"] as? [fetchDictionary] {
                    
                    items = createComponentsArray(from: components)
                    
                    items.forEach({ (item) in
                                            
                        switch item.componentType
                        {
                        case .person :
                            print("person - \(item.name)")
                            
                        case .bannerAppAdunit :
                            print("BannerAppAdunit - \(item.name)")
                            
                        case .nativeAdsAdunit:
                            print("NativeAdsAdunit - \(item.name)")
                        }
                    })
                    delegate?.dataControllerDidFinishUpdateData(self, with: nil)
                }
            } catch {
                // handle error
            }
        }
    }
    
    
    //MARKL Private methods
    private func createComponentsArray(from array: [[String:Any]]?) -> [Component]
    {
        guard let array = array else { return [Component]() }
        var componentsArray = [Component]()
        for component  in array
        {
            guard let object = ComponentsGenerator.generateComponent(from: component) else { continue }
            componentsArray.append(object)
            
        }
        return componentsArray
    }
}

extension AdsDataController : DataController
{
    func numberOfSections() -> Int
    {
        return items.count
    }
    func numberOfRows(inSection section: Int) -> Int
    {
        let section = items[section] as Component
        guard let sectionItems = section.items else { return 0 }
        
        return sectionItems.count
    }
    func object(for indexPath: IndexPath) -> Any?
    {
        let section = items[indexPath.section] as Component
        guard let sectionItems = section.items else { return nil }

        return sectionItems[indexPath.row]
    }
    func didSelectObject(inIndexPath indexPath: IndexPath)
    {
        
    }
}

