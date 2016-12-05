//
//  SettingsViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import GoogleMobileAds
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    var maxCharLength : Int = 32
    var changeVal : Int = 0
    
    
    @IBOutlet weak var SpecialCharsText: UITextField!
    @IBAction func MaxLengthSwitchChanged(_ sender: UISwitch) {
        MainViewController.cyaSettings.isMaxLengthOn = sender.isOn
        MainViewController.cyaSettings.mainView.genUserHash()
    }
    
    @IBAction func AddUpperCaseSwitchChanged(_ sender: UISwitch) {
        MainViewController.cyaSettings.isUppercaseOn = sender.isOn
        MainViewController.cyaSettings.mainView.genUserHash()
    }
    
    
    @IBAction func AddSpecialCharsSwitchChanged(_ sender: UISwitch) {
        MainViewController.cyaSettings.isSpecialCharsOn = sender.isOn
        MainViewController.cyaSettings.mainView.genUserHash()
    }
    
    @IBAction func SpecialCharsEditingChanged(_ sender: UITextField) {
        MainViewController.cyaSettings.specialChars = sender.text!
    }
  
    @IBAction func MaxCharsValueChanged(_ sender: UIStepper) {
        changeVal = Int(sender.value)
        MainViewController.cyaSettings.maxPassLength = changeVal
        updateCharVal()
        
            MainViewController.cyaSettings.mainView.genUserHash()
 
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func updateCharVal(){
        MaxCharsText.text = String(changeVal)
    }
    
    @IBOutlet weak var maxCharsStepper: UIStepper!
    @IBOutlet weak var MaxCharsText: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SpecialCharsText.delegate = self
        maxCharsStepper.value =  Double(maxCharLength)
        MainViewController.cyaSettings.maxPassLength = Int(maxCharsStepper.value)
        MaxCharsText.text = String(Int(maxCharsStepper.value))
         print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        
    }
    
 
   
    @IBOutlet weak var AdMobs: GADBannerView!
   
    @IBOutlet weak var SuperView: UIView!
    func loadAd(){

       // AdMobs.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    AdMobs.adUnitID = "ca-app-pub-6286879032545261/2319897125"
        AdMobs.rootViewController = self
       AdMobs.load(GADRequest())
       //SuperView.backgroundColor = UIColor.black;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        /* var width : Int = Int(UpperView.frame.width)
        var height : Int = Int(UpperView.frame.height)
        MainOutLabel.text = String(describing: width) + "  " + String(describing: height)
        if (g == nil){
        g = GridPassView(frame: UpperView.frame, width: width, height: height)
        
        
        g?.tag = 101
        UpperView.addSubview(g!)
        } */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAd()
    }

}

