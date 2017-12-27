//
//  ExtentionUIApplication.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 26/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func mainWindow() -> UIWindow? {
        let windows = self.windows
        
        if windows.count == 0 { return nil }
        
        return windows[0]
    }
}
