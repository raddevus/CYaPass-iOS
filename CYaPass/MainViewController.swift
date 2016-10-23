//
//  MainViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate{

    
   
   
    @IBOutlet weak var TopGridView: UIView!
    
    @IBOutlet weak var SiteKeyTextField: UITextField!
    
    @IBOutlet weak var SiteKeyPicker: UIPickerView!
    @IBOutlet weak var ClearGridButton: UIButton!
    @IBOutlet weak var HashLabelOutlet: UILabel!
    var g :GridPassView? = nil
    var screenSize: CGRect? = nil
    var topGridViewWidth : Int? = nil
    var topGridViewHeight : Int? = nil
    let gridViewTag = 100
    let blueFontColor = UIColor(red: 240/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    let greenFontColor = UIColor(red: 120/255.0, green: 100/255.0, blue: 75/255.0, alpha: 1.0)
    var siteKeyPickerValues :[String] = ["computer", "appleId", "linkedin"]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.SiteKeyTextField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func AddSiteButtonClicked(_ sender: AnyObject) {
        if SiteKeyTextField.text != nil && !(SiteKeyTextField.text?.isEmpty)! {
            addNewSiteKey(key: SiteKeyTextField.text!)
            SiteKeyTextField.text = ""
            //[SiteKeyTextField, resignFirstResponder] as [Any]
            
        }
    }
    @IBAction func ClearGridButtonClicked(_ sender: AnyObject) {
        clearGrid()
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return siteKeyPickerValues.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return siteKeyPickerValues[row]
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    func addSubView(forceRemoveGridView : Bool = false){
        
        if forceRemoveGridView{
            if let viewWithTag = self.view.viewWithTag(gridViewTag){
                viewWithTag.removeFromSuperview()
                
                g = nil
            }
        }
        topGridViewWidth = Int(TopGridView.frame.width)
        
        
        topGridViewHeight = Int(TopGridView.frame.height)
        

        g = GridPassView(frame: view.frame, width: topGridViewWidth!, height: topGridViewHeight!)
        g?.tag = gridViewTag
        TopGridView.addSubview(g!)
    }
    
    func clearGrid(){
        addSubView(forceRemoveGridView: true)
        
    }
    
    func addNewSiteKey(key : String){
        siteKeyPickerValues.append(key.trimmingCharacters(in: .whitespaces))
        SiteKeyPicker.reloadAllComponents()
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        genUserHash()
        
    }
    
    func genUserHash(){
        if g?.outValue != nil{
            
            let selectedItemValue :String = siteKeyPickerValues[SiteKeyPicker.selectedRow(inComponent: 0)]
            let hg: HashGenerator = HashGenerator(clearText:  g!.outValue + selectedItemValue)
            // ORIGINAL LINE FOLLOWS
            // let hg: HashGenerator = HashGenerator(clearText: (g?.outValue)! + selectedItemValue)
            SettingsViewController.maxCharsSwitch
            HashLabelOutlet.text = hg.finalHash
            UIPasteboard.general.string = hg.finalHash
        }
        // ###### following line allows testing of postvalues
        // HashLabelOutlet.text = String(describing: g?.us.PostValue)
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            genUserHash()
    }
    
    override func viewDidLayoutSubviews() {
        if g == nil{
            addSubView()
        }
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        addSubView(forceRemoveGridView: true)
    }
}

