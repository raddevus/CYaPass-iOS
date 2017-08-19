//
//  SettingsViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

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
        
        
    }
  
}

