//
//  WelcomeViewController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 18/12/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

class WelcomeViewController: AdsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAdUnitViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let adUnitViewController = storyboard.instantiateViewController(withIdentifier: "AdUnitViewController") as! AdUnitViewController
        adUnitViewController.modalPresentationStyle = .overCurrentContext
        adUnitViewController.rootViewController = self
        present(adUnitViewController, animated: true, completion: nil)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        switch motion {
        case UIEventSubtype.motionShake: presentAdUnitViewController()
        default: return
        }
    }

}
