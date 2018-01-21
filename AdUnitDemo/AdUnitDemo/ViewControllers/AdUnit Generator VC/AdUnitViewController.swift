//
//  ViewController.swift
//  AdUnitDemo
//
//  Created by Itamar Nakar on 26/09/2017.
//  Copyright © 2017 ynet. All rights reserved.
//

import UIKit

class AdUnitViewController: UIViewController {
    
    private var channelNumber   : String  = ""
    private var generatedAdunit : String  = ""
    private var productType     = AdProductType(rawValue: 0)!
    var rootViewController      : AdsBaseViewController?
    {
        didSet
        {
            print(rootViewController)
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var channelNameTextField: UITextField!
    @IBOutlet weak var generatedAdUnitLabel: UILabel!
    
    //MARK: - Actions
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func generateButton(_ sender: UIButton)
    {
        view.endEditing(true)
        generatedAdUnitLabel.textColor = UIColor.black
        
        generatedAdunit = AdUnitManager.getAdunitCode(forAdProduct: productType, andCategoryId: channelNumber)
        generatedAdUnitLabel.text = generatedAdunit
        
        generatedAdUnitLabel.sizeToFit()
        view.layoutIfNeeded()
        view.setNeedsLayout()
        
        provideAdWithAdunit(forAdProduct: productType, and: generatedAdunit)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTextField?.delegate = self
        channelNameTextField?.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("")
    }
    
    //MARK: - Private Methods
    private func getProductType(by productName:String?) -> AdProductType
    {
        let defaultReturnType = AdProductType(rawValue: 0)!
        guard let productNumber = Int(productName!)             else {return defaultReturnType}
        guard let type = AdProductType(rawValue: productNumber) else { return defaultReturnType}
        return type
    }
    
    private func provideAdWithAdunit(forAdProduct adProduct : AdProductType, and adUnit : String)
    {
        guard let rootViewController = rootViewController else { return }
        
        switch adProduct
        {
        case .transition:
            rootViewController.interstitialProvider = InterstitialProvider(with: adUnit,
                                                        customParams: nil,
                                                        rootViewController: rootViewController,
                                                        andDelegate: rootViewController)
            dismiss(animated: false, completion: nil)

        default:
            rootViewController.adProvider = BannerAdProvider(with: adUnit,
                                    type: .bannerSticky,
                                    customParams: nil,
                                    rootViewController: rootViewController,
                                    andDelegate: rootViewController)
        }
        
        
    }
}

//MARK: - extension
extension AdUnitViewController : UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        
        switch textField {
        case productTextField:
            productType = getProductType(by: textField.text)
        case channelNameTextField:
            guard let validatedChannelNumber = textField.text else { break }
            channelNumber = validatedChannelNumber
            
        default:
            break
        }
        print("textFields: \(productType) \(channelNumber)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
}
