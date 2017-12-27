//
//  GoogleTagManagerHelper.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 02/10/2017.
//  Copyright © 2017 ynet. All rights reserved.
//
protocol GoogleTagManagerHelperDelegate : class
{
    func gtmContainer(_ gtmContainer : TAGContainer!)
    func defaultContainer(_ gtmContainer : TAGContainer!)
}


class GoogleTagManagerHelper: NSObject
{
    weak var        delegate    : GoogleTagManagerHelperDelegate?
    fileprivate let gtm         = TAGManager.instance()!
    
    func initiateGoogleTagManager()
    {
        gtm.logger.setLogLevel(kTAGLoggerLogLevelVerbose)
        
        TAGContainerOpener.openContainer(withId: "GTM-WQ25SD5",
                                               tagManager: gtm,
                                               openType: kTAGOpenTypePreferFresh,
                                               timeout: nil,
                                               notifier: self)
        
        delegate?.defaultContainer(gtm.openContainer(byId: "GTM-WQ25SD5", callback: nil))
    }
}

extension GoogleTagManagerHelper : TAGContainerOpenerNotifier
{
    func containerAvailable(_ container: TAGContainer!)
    {
        container.refresh()
        guard let gtmContainer = container else {return}
        delegate?.gtmContainer(gtmContainer)
    }
}
