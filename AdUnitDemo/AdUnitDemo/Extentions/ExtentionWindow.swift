//
//  ExtentionWindow.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 26/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func getMainWindow() -> UIWindow? {
        let windows = UIApplication.shared.windows
        
        if windows.count == 0 { return nil }
        
        return windows[0]
    }
    
    var mainWindow : UIWindow? {
        get{
            let windows = UIApplication.shared.windows
            
            if windows.count == 0 { return nil }
            
            return windows[0]
        }
        set{}
    }
}
