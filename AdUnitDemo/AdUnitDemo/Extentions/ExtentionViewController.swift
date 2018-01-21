//
//  ExtentionViewController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 27/09/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

extension UIViewController
{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        switch motion {
        case UIEventSubtype.motionShake: presentAdUnitViewController()
        default: return
        }
    }
    
    private func presentAdUnitViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let adUnitViewController = storyboard.instantiateViewController(withIdentifier: "AdUnitViewController") as! AdUnitViewController
        adUnitViewController.modalPresentationStyle = .overCurrentContext
        adUnitViewController.rootViewController = self as? AdsBaseViewController
        present(adUnitViewController, animated: true, completion: nil)
    }
}
