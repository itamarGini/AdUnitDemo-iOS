//
//  AdSplashView.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 26/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

class AdSplashView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lowNetworkLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("AdSplashView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
