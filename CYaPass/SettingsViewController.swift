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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        var width : Int = Int(UpperView.frame.width)
        var height : Int = Int(UpperView.frame.height)
        MainOutLabel.text = String(describing: width) + "  " + String(describing: height)
        g = GridPassView(frame: UpperView.frame, width: width, height: height)
        
        //g?.externalViewContoller = nil//self
        g?.tag = 101
        UpperView.addSubview(g!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}

