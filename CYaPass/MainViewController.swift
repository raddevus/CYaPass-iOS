//
//  MainViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import GoogleMobileAds
import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var TopGridView: UIView!
  
    var textField : UITextField? = nil
    
    @IBOutlet weak var SiteKeyPicker: UIPickerView!
    @IBOutlet weak var ClearGridButton: UIButton!
    @IBOutlet weak var HashLabelOutlet: UILabel!
    @IBOutlet weak var ShowPasswordSwitch: UISwitch!
    
    
    var g :GridPassView? = nil
    var screenSize: CGRect? = nil
    var topGridViewWidth : Int? = nil
    var topGridViewHeight : Int? = nil
    let gridViewTag = 100
    let blueFontColor = UIColor(red: 240/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    let greenFontColor = UIColor(red: 120/255.0, green: 100/255.0, blue: 75/255.0, alpha: 1.0)
    var siteKeyPickerValues :[String] = []
    public static var cyaSettings : CyaSettings!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        MainViewController.cyaSettings = CyaSettings(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func ShowPasswordSwitchChanged(_ sender: UISwitch) {
        genUserHash()
    }
    
    @IBAction func DeleteSiteClicked(_ sender: UIButton) {
        if (siteKeyPickerValues.count <= 0) {return }
        let selItemIdx : Int  = self.SiteKeyPicker.selectedRow(inComponent: 0)
        let currentKey : String = siteKeyPickerValues[selItemIdx]
        let alert = UIAlertController(title: "Delete key?", message: "Are you sure you want to delete the item: \(currentKey)?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                
                self.siteKeyPickerValues.remove(at: selItemIdx)
                self.SiteKeyPicker.reloadAllComponents()
                self.genUserHash()
                UserDefaults.standard.set(self.siteKeyPickerValues, forKey: "siteKeys")
                UserDefaults.standard.synchronize()
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
   func configurationTextField(textField: UITextField!)
    {
        if textField != nil {
            
            self.textField = textField!        //Save reference to the UITextField
            self.textField?.text = ""
        }
    }
    
    @IBAction func AddSiteButtonClicked(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add New Key?", message: "Please type the key you'd like to enter", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                if self.textField?.text != nil && !(self.textField?.text?.isEmpty)! {
                    self.addNewSiteKey(key: (self.textField?.text!)!)
                    self.textField?.text = ""
                    self.SiteKeyPicker.selectRow((self.siteKeyPickerValues.count)-1, inComponent: 0, animated: true)
                    self.genUserHash()
                    UserDefaults.standard.set(self.siteKeyPickerValues, forKey: "siteKeys")
                    UserDefaults.standard.synchronize()
                    
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
            }
    
    @IBAction func ClearGridButtonClicked(_ sender: AnyObject) {
        clearGrid()
        HashLabelOutlet.text = ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return siteKeyPickerValues.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if (siteKeyPickerValues.count > 0){
            return siteKeyPickerValues[row]
        }
        return nil
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
        UIPasteboard.general.items.removeAll()
        MainViewController.cyaSettings.shapeValue = nil
    }
    
    func addNewSiteKey(key : String){
        siteKeyPickerValues.append(key.trimmingCharacters(in: .whitespaces))
        SiteKeyPicker.reloadAllComponents()
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        genUserHash()
        
    }
    
    func genUserHash(){
        if MainViewController.cyaSettings.shapeValue != nil{
            
            if (siteKeyPickerValues.count <= 0){
                return
            }
            let selectedItemValue :String = siteKeyPickerValues[SiteKeyPicker.selectedRow(inComponent: 0)]
            if (MainViewController.cyaSettings.shapeValue == "0") {return}
            let hg: HashGenerator = HashGenerator(clearText:  MainViewController.cyaSettings.shapeValue + selectedItemValue)
            if (ShowPasswordSwitch.isOn){
                HashLabelOutlet.text = hg.finalHash
            }
            else{
                HashLabelOutlet.text = ""
            }
            UIPasteboard.general.string = hg.finalHash
        }
        // ###### following line allows testing of postvalues;
        // HashLabelOutlet.text = String(describing: g?.us.PostValue)
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            genUserHash()
    }
    
    @IBOutlet weak var AdMobs: GADBannerView!
    func loadAd(){
        
        // AdMobs.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        AdMobs.adUnitID = "ca-app-pub-6286879032545261/2319897125"
        AdMobs.rootViewController = self
        AdMobs.load(GADRequest())
        //SuperView.backgroundColor = UIColor.black;
    }
    
    override func viewDidLayoutSubviews() {
        if g == nil{
            addSubView()
        }
        if (siteKeyPickerValues.count <= 0){
            if (UserDefaults.standard.array(forKey : "siteKeys") != nil){
             siteKeyPickerValues = UserDefaults.standard.array(forKey: "siteKeys") as! [String]
            }
        }
        loadAd()
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        addSubView(forceRemoveGridView: true)
    }
}

