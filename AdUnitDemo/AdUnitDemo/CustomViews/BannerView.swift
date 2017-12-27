//
//  BannerView.swift
//  AdProvider
//
//  Created by Itamar Nakar on 11/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerView: GADBannerView {
    
    // MARK: - Initialization
    fileprivate enum InitMethod {
        case coder(NSCoder)
        case frame(CGRect)
        case adSize(GADAdSize)
    }
    convenience override init(frame: CGRect) {
        self.init(.frame(frame))
    }
    convenience required init(coder aDecoder: NSCoder) {
        self.init(.coder(aDecoder))
    }
    convenience override init(adSize: GADAdSize) {
        self.init(.adSize(adSize))
    }
    convenience init(adSize: GADAdSize, rootView : UIView) {
        self.init(.adSize(adSize))
        self.addBannerViewToView(rootView)
    }
    fileprivate init(_ initMethod: InitMethod) {
        switch initMethod {
        case let .coder(coder): super.init(coder: coder)!
        case let .frame(frame): super.init(frame: frame)
        case let .adSize(adSize): super.init(adSize: adSize)
        }
    }
    

    //MARK: - Private Helpers
    
    func addBannerViewToView(_ rootView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(self)
        rootView.addConstraints(
            [NSLayoutConstraint(item: self,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: rootView.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: self,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: rootView,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}
