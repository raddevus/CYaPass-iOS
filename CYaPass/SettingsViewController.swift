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
  
    @IBOutlet weak var maxCharsSwitch: UISwitch!
    
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
/*    @IBAction func TouchCharCount(_ sender: AnyObject) {
        
        var currentValue : Int = Int(MaxCharsText.text!)!
        maxCharLength = currentValue + 1
        MaxCharsText.text = String(maxCharLength)
        
    } */
    @IBOutlet weak var UpperView: UIView!
    @IBOutlet weak var MainOutLabel: UILabel!
    var g : UIView! = nil
    @IBOutlet weak var TopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SpecialCharsText.delegate = self
        maxCharsStepper.value =  Double(maxCharLength)
        MainViewController.cyaSettings.maxPassLength = Int(maxCharsStepper.value)
        MaxCharsText.text = String(Int(maxCharsStepper.value))
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
        
    }

}

