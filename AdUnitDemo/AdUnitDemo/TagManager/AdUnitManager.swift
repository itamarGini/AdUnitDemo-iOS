//
//  AdUnitManager.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 02/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import Foundation

let kEmptyString = String()

enum AdProductType : Int
{
    case none               = 0
    case banners            = 1
    case transition         = 2
    case adsense            = 3
    case stripMarketing     = 4
    case liveBox            = 5
    case justAd             = 6
    case marketingOrdering  = 7
    case preroll            = 8
    case postroll           = 9
}

private enum GTMContainerKeys : String
{
    case isGTMActive            = "is_gtm_active"
    case isNewMediaTreeActive   = "is_new_media_tree_active"
    case isCorrelatorEnabled    = "is_correlator_enabled"
    case isAutoplayVideoMutable = "is_autoplay_video_mutable"
    case isWebKitEnabled        = "is_web_kit_enable"
    case accountNumber          = "account_number"
    case site                   = "site"
    case platform_iphone        = "platform_iphone"
    case defaultChannelKey      = "0"
    case defaultIMAChannelKey   = "2"
    
    case productPrefix          = "product_"
    case levelsCount            = "_levels_count"
    case maxProductLevels       = "max_product_levels"
    case videoTagPrefix         = "video_tag_prefix"
    case videoTagSuffix         = "video_tag_suffix"
    case videoTagPathPrefix     = "video_tag_path_prefix"
    case videoTagDescriptionUrlPrefix = "video_tag_description_url_prefix"
    
    case wordSeparator1 = "p1"
    case wordSeparator2 = "p2"
    case wordSeparator3 = "p3"
    case wordSeparator4 = "p4"
    case wordSeparator5 = "p5"
    case wordSeparator6 = "p6"
}

struct AdUnitManager
{
    //MARK: - Public Methods
    static func getAdunitCode(forAdProduct adProduct    : AdProductType,
                              andCategoryId categoryId  : String?) -> String
    {
        assert(AdUnitManager.isAdNotForVideo(product: adProduct),
               """
                \n🍌 You Are Calling The Wrong Method..🍌
                For Video Ads Use \"getVideoAdunitCode\" Method.\n
               """)
        
        return AdUnitManager.getAdunitTag(for       : adProduct,
                                          categoryId: categoryId)
    }
    
    static func getVideoAdunitCode(forAdProduct adProduct: AdProductType,
                                   categoryId   : String?,
                                   customParams : AdCustomParams?) -> String
    {
        return AdUnitManager.getAdunitTag(for           : adProduct,
                                          categoryId    :categoryId,
                                          customParams  : customParams)
    }
}

extension AdUnitManager
{
    static private func getAdunitTag(for adProduct : AdProductType,
                                     categoryId    : String?,
                                     customParams  : AdCustomParams? = nil) -> String
    {
        var adUnitTag : String?
        
        if let container = UserInSession.shared.gtmContainer,
            container.string(forKey: GTMContainerKeys.isGTMActive.rawValue) == "TRUE"
        {
            adUnitTag = getAdUnit(forAdProduct  : adProduct,
                                  categoryId    : categoryId,
                                  customParams  : customParams,
                                  andContainer  : container)
        }
        else
        {
            adUnitTag = getNoneActiceGTMAdunits(forAdProduct : adProduct,
                                                andCategoryId: categoryId)
        }
        
        guard let returneString = adUnitTag else { return kEmptyString}
        
        print(">>>adUnitCode: \(returneString)")
        return returneString
    }
}

//MARK: - Private Methods
extension AdUnitManager
{
    static private func getAdUnit(forAdProduct product  : AdProductType,
                                  categoryId            : String?,
                                  customParams          : AdCustomParams?,
                                  andContainer container: TAGContainer!)  -> String
    {
        guard let container = container else {return kEmptyString}
        
        let productKey = container.string(forKey: "\(GTMContainerKeys.productPrefix.rawValue)\(product.rawValue)")!
        
        /*
         Current Media Tree Has String Duplications ('TempAduintAddition') We Must support.
         For Example:
         Adunit in New Media Tree:          "/6870/Ynet/iPhone/Banners/Channels"
         Same Adunit in Current Media Tree: "/6870/ynet_mobile/Ynet_iPhone_Banners/Ynet_iPhone_Banners_Channels"
         */
        
        let adunitString = AdUnitManager.getAduint(by: product,
                                                   productKey: productKey,
                                                   categoryId: categoryId,
                                                   with: container)
        
        let tempAdunitAdditionsString = AdUnitManager.getTempAduintAddition(by: product,
                                                                            productKey: productKey,
                                                                            categoryId: categoryId,
                                                                            with: container)
        
        var combinedAdunitString = "\(adunitString)\(tempAdunitAdditionsString)"
        
        
        switch product
        {
        case .preroll,.postroll:
            guard let customParams = customParams else { return combinedAdunitString }
            
            combinedAdunitString = AdUnitManager.getVideoAdunitAddition(by: customParams,
                                                                        adunitString : combinedAdunitString,
                                                                        with: container)
        default:
            break
        }
        
        print(">>> Adunit Tag: \(combinedAdunitString)")
        return combinedAdunitString
    }
    
    static private func getAduint(by product    : AdProductType,
                                  productKey    : String,
                                  categoryId    : String?,
                                  with container : TAGContainer!) -> String
    {
        var returnString : String
        
        let productLevelsKey = "\(GTMContainerKeys.productPrefix.rawValue)\(product.rawValue)\(GTMContainerKeys.levelsCount.rawValue)"
        
        guard let productLevelsCount = Int(container.string(forKey: productLevelsKey)!) ?? Int(container.string(forKey: GTMContainerKeys.maxProductLevels.rawValue)!) else { return kEmptyString }
        
        
        switch (productLevelsCount) {
        case 0: // example: /6870
            returnString  = "\(container.string(forKey: GTMContainerKeys.wordSeparator1.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.accountNumber.rawValue)!)"
            
        case 1: // example: /6870/Ynet
            returnString  = "\(container.string(forKey: GTMContainerKeys.wordSeparator1.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.accountNumber.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator2.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.site.rawValue)!)"
            
        case 2: // example: /6870/Ynet/Iphone
            returnString  = "\(container.string(forKey: GTMContainerKeys.wordSeparator1.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.accountNumber.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator2.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.site.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator3.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.platform_iphone.rawValue)!)"
            
        case 3: // example: /6870/Ynet/Iphone/Banners
            returnString  = "\(container.string(forKey: GTMContainerKeys.wordSeparator1.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.accountNumber.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator2.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.site.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator3.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.platform_iphone.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator4.rawValue)!)"
            returnString += "\(container.string(forKey: productKey)!)"
            
        case 4: // example: /6870/Ynet/Iphone/Banners/News
            returnString  = "\(container.string(forKey: GTMContainerKeys.wordSeparator1.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.accountNumber.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator2.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.site.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator3.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.platform_iphone.rawValue)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator4.rawValue)!)"
            returnString += "\(container.string(forKey: productKey)!)"
            returnString += "\(container.string(forKey: GTMContainerKeys.wordSeparator5.rawValue)!)"
            returnString += "\(container.string(forKey: AdUnitManager.validateKey(for: categoryId, product: product, and: container))!)"
            
        default:
            returnString = kEmptyString;
        }
        
        return returnString
    }
    
    static private func getVideoAdunitAddition(by customParams : AdCustomParams,
                                               adunitString    : String,
                                               with container  : TAGContainer!) -> String
    {
        let videoTagPrefix      = container.string(forKey: GTMContainerKeys.videoTagPrefix.rawValue)!
        guard let adunitString  = adunitString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {return kEmptyString}
        let descriptionUrl      = AdUnitManager.getDesctiptionURLAdditions(by: customParams, with: container)
        let custParams          = AdUnitManager.getCustParamsAdditions(by : customParams, with : container)
        let videoTagSuffix      = container.string(forKey: GTMContainerKeys.videoTagSuffix.rawValue)!
        
        return "\(videoTagPrefix)\(adunitString)\(descriptionUrl)\(custParams)\(videoTagSuffix)"
    }
    
    static private func getDcPathAdditions(by customParams : AdCustomParams,
                                           with container  : TAGContainer!) -> String
    {
        guard let dcPath = customParams.dcPath else { return kEmptyString }
        var dcPathPrefix = kEmptyString
        
        if dcPath.count > 0
        {
            dcPathPrefix = container.string(forKey: GTMContainerKeys.videoTagPathPrefix.rawValue)!
        }
        
        return "\(dcPathPrefix)\(dcPath)"
    }
    
    static private func getArticleIdAdditions(by customParams : AdCustomParams) -> String
    {
        guard let articleId = customParams.articleId else { return kEmptyString }
        
        if articleId.count > 0
        {
            return "%26yncd%3D\(articleId)"
        }
        else
        {
            return kEmptyString
        }
    }
    
    static private func getDesctiptionURLAdditions(by customParams : AdCustomParams,
                                                   with container  : TAGContainer!) -> String
    {
        guard let descriptionUrl = customParams.descriptionUrl else { return kEmptyString }
        var descriptionUrlPrefix = kEmptyString
        
        if descriptionUrl.count > 0
        {
            descriptionUrlPrefix = container.string(forKey: GTMContainerKeys.videoTagDescriptionUrlPrefix.rawValue)!
        }
        
        guard let returnString = "\(descriptionUrlPrefix)\(descriptionUrl)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {return kEmptyString}
        
        return returnString
    }
    
    static private func getCustParamsAdditions(by customParams : AdCustomParams,
                                               with container  : TAGContainer!) -> String
    {
        let dcPathAdditions = AdUnitManager.getDcPathAdditions(by: customParams, with: container)
        let articleId = AdUnitManager.getArticleIdAdditions(by: customParams)
        let numberOfViews = AdUnitManager.getNumberOfViewsForVideoAd()
        let appVersion = AdUnitManager.getAppVersion()
        
        return "\(dcPathAdditions)\(articleId)\(numberOfViews)\(appVersion)"
    }
}

//MARK: - Private helpers
extension AdUnitManager
{
    static private func isAdNotForVideo(product : AdProductType) -> Bool
    {
        switch product
        {
        case .preroll,.postroll:
            return false
            
        default:
            return true
        }
    }
    
    static private func getNoneActiceGTMAdunits(forAdProduct adProduct : AdProductType,
                                                andCategoryId categoryId : String?) -> String
    {
        print(">>>There is no Container, We are using default Splash Transition AdUnit")
        
        switch adProduct {
        case .transition:
            return "/6870/ynet_mobile/Ynet_iPhone_Transitions/Ynet_iPhone_Transitions_Splash"
        default:
            return "/6870/ynet_mobile/Ynet_iPhone_Banners/Ynet_iPhone_Banners_Main"
        }
    }
    
    static private func getTempAduintAddition(by product   : AdProductType,
                                              productKey   : String,
                                              categoryId   : String?,
                                              with container: TAGContainer!) -> String
    {
        //Working with GTM 'Temporary Channels' Value collection
        if container.string(forKey: GTMContainerKeys.isNewMediaTreeActive.rawValue)! == "FALSE"
        {
            switch product
            {
            case .transition,.banners, .stripMarketing, .liveBox:
                return validatedTemporaryAdunit(for: productKey,
                                                categoryId: categoryId,
                                                with: container)
            default:
                return kEmptyString
            }
        }
        return kEmptyString
    }
    
    static private func validatedTemporaryAdunit(for productKey : String,
                                                 categoryId     : String?,
                                                 with container : TAGContainer!) -> String
    {
        guard let categoryId = categoryId else { return kEmptyString}
        var tempCategoryKey       = "\(productKey)\(categoryId)"
        var tempCategoryAdunit    = container.string(forKey: tempCategoryKey)!
        
        if tempCategoryAdunit.isEmpty
        {
            tempCategoryKey       = "\(productKey)\(categoryId)"
            tempCategoryAdunit    = container.string(forKey: GTMContainerKeys.defaultChannelKey.rawValue)!
        }
        
        return tempCategoryAdunit
    }
    
    static private func validateKey(for categoryId  : String?,
                                    product         : AdProductType,
                                    and container   : TAGContainer!) -> String
    {
        // if Channel does not exist use DEFAULT Channel
        // Preroll/Postroll previos media Tree - default fallback channel was "News"
        
        let defaultCategoryAdunit       = container.string(forKey: GTMContainerKeys.defaultChannelKey.rawValue)!
        let defaultVideoCategoryAdunit  = container.string(forKey: GTMContainerKeys.defaultIMAChannelKey.rawValue)!
        
        guard let categoryId = categoryId else {return defaultCategoryAdunit}
        var categoryAdunit = "\(container.string(forKey: categoryId))"
        
        if categoryAdunit.isEmpty
        {
            if container.string(forKey: categoryId) == "FALSE"
            {
                switch product
                {
                case AdProductType.preroll,
                     AdProductType.postroll:
                    categoryAdunit = defaultVideoCategoryAdunit
                    
                default:
                    categoryAdunit = defaultCategoryAdunit
                }
            }
        }
        return categoryAdunit
    }
    
    static private func getNumberOfViewsForVideoAd() -> String
    {
        // Current instructions are to reset counter every midnight
        var viewCounter : Int = 1
        let currentMidnight : Date = Calendar(identifier: .gregorian).startOfDay(for: Date())
        let previosMidnight : Date = UserDefaults.standard.object(forKey: "view_counter_refresh_time") as! Date
        
        if currentMidnight == previosMidnight
        {
            viewCounter = UserDefaults.standard.integer(forKey: "video_view_counter")
            viewCounter += 1
        }
        
        UserDefaults.standard.set(currentMidnight, forKey: "view_counter_refresh_time")
        UserDefaults.standard.set(viewCounter, forKey: "video_view_counter")
        UserDefaults.standard.synchronize()
        
        // base string: "%26view%3D\(viewCounter)"
        return String(viewCounter)
    }
    
    static private func getAppVersion() -> String
    {
        guard let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") else {return kEmptyString}
        return "%26appVersion%3D\(appVersion)"
    }
}


