//
//  MainViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    @IBOutlet weak var TopGridView: UIView!
    
    @IBOutlet weak var ClearGridButton: UIButton!
    @IBOutlet weak var HashLabelOutlet: UILabel!
    var g :GridPassView? = nil
    var screenSize: CGRect? = nil
    var topGridViewWidth : Int? = nil
    var topGridViewHeight : Int? = nil
    let gridViewTag = 100
    let blueFontColor = UIColor(red: 240/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    let greenFontColor = UIColor(red: 120/255.0, green: 100/255.0, blue: 75/255.0, alpha: 1.0)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func ClearGridButtonClicked(_ sender: AnyObject) {
        clearGrid()
    }
    
    func addSubView(){
        
        if let viewWithTag = self.view.viewWithTag(gridViewTag){
            viewWithTag.removeFromSuperview()
            g = nil
        }
        topGridViewWidth = Int(TopGridView.frame.width)
        
        
        topGridViewHeight = Int(TopGridView.frame.height)
        

        g = GridPassView(frame: TopGridView.frame, width: topGridViewWidth!, height: topGridViewHeight!)
        g?.tag = gridViewTag
        TopGridView.addSubview(g!)
        
    }
    
    func clearGrid(){
        
        addSubView()
    }
    
    func genUserHash(){
        //let hg: HashGenerator = HashGenerator(clearText: userClearText.text! +  (g?.outValue)!)
        if g?.outValue != nil{
            let hg: HashGenerator = HashGenerator(clearText: (g?.outValue)!)
            HashLabelOutlet.text = hg.finalHash
            UIPasteboard.general.string = hg.finalHash
        }
    //    outputMsg.text = hg.finalHash
        
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
        g=nil
        addSubView()
    }
}

