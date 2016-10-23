//
//  SettingsViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var maxCharLength : Int = 32
    
    @IBOutlet weak var MaxCharsText: UITextField!
    @IBAction func TouchCharCount(_ sender: AnyObject) {
        
        var currentValue : Int = Int(MaxCharsText.text!)!
        maxCharLength = currentValue + 1
        MaxCharsText.text = String(maxCharLength)
        
    }
    @IBOutlet weak var UpperView: UIView!
    @IBOutlet weak var MainOutLabel: UILabel!
    var g : UIView! = nil
    @IBOutlet weak var TopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MaxCharsText.text = String(maxCharLength)
        
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

