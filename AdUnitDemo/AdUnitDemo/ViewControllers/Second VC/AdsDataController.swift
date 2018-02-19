//
//  AdsDataController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 17/01/2018.
//  Copyright © 2018 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdsDataController: NSObject
{
    typealias fetchDictionary      = Dictionary<String, AnyObject>
    typealias bannerBoolDictionary = Dictionary<GADBannerView, Bool>
    
    //MARK: - Private members
    private weak var delegate : DataControllerDelegate?
    private var items = [Component]()
    
    // Ads manegement Properties
    var asdToLoad       = [BannerAppAdunitMetaData]()
    var loadStateForAds = bannerBoolDictionary()    
    
    
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
                        case .artist :
                            print("artist - \(item.name)")
                            
                        case .bannerAppAdunit :
                            print("BannerAppAdunit - \(item.name)")
                            
                        case .nativeAdsAdunit:
                            print("NativeAdsAdunit - \(item.name)")
                            
                        default : print("None - \(item.name)")
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
            if let object = object as? BannerAppAdunitMetaData
            {
                asdToLoad.append(object)
            }
            componentsArray.append(object)
        }
        return componentsArray
    }
    
    private func createNativeStyleAd(by object : BannerAppAdunitMetaData)
    {
        let customParam = AdCustomParams(dcPath: "8.Central-1.Home", descriptionUrl: "")
        let adView = BannerAdProvider.init(with: object.link,
                                           type: Ads.AdsType.nativeAd,
                                           customParams: customParam,
                                           rootViewController: delegate as! UIViewController,
                                           andDelegate: delegate as! BannerAdProviderProtocol)
        
//        let adSize = GADAdSizeFromCGSize(CGSize(width: object.imageWidth, height: object.imageHeight))
//        let adView = DFPBannerView.init(adSize: adSize)
//        adView.validAdSizes = [NSValueFromGADAdSize(adSize), NSValueFromGADAdSize(kGADAdSizeFluid)]
//        adView.adUnitID = object.link
//        adView.rootViewController? = delegate as! UIViewController
//        adView.delegate = delegate as!
//        adView.adSizeDelegate? = delegate as! UIViewController
    }
}

extension AdsDataController : DataController
{
    func header(for section: Int) -> HeaderMetaData?
    {
        return section < items.count ? items[section].headerMetaData : nil
    }
    
    func type(of section: Int) -> Ads.ComponentsType
    {
        return section < items.count ? items[section].componentType : .none
    }
    
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
        print(section)
        guard let sectionItems = section.items else { return nil }

        return sectionItems[indexPath.row]
    }
    func didSelectObject(inIndexPath indexPath: IndexPath)
    {
        
    }
}

