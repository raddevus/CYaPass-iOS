//
//  SettingsViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var UpperView: UIView!
    @IBOutlet weak var MainOutLabel: UILabel!
    var g : UIView!
    @IBOutlet weak var TopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
       /* let firstFrame : CGRect = CGRect(origin:CGPoint(x:0,y:0), size:CGSize(dictionaryRepresentation: 0 as! CFDictionary)!)
       
        
        g = GridPassView(frame: firstFrame, width: 50, height: 50)
        
        //g?.externalViewContoller = nil//self
        g?.tag = 100
        TopView.addSubview(g!)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        var width : Int = Int(UpperView.frame.width)
        var height : Int = Int(UpperView.frame.height)
        MainOutLabel.text = String(describing: width) + "  " + String(describing: height)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}

