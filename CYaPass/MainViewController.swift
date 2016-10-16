//
//  MainViewController.swift
//  CYaPass
//
//  Created by roger deutsch on 10/8/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    
        @IBOutlet weak var ClearGridButton: UIButton!
    @IBOutlet weak var HashLabelOutlet: UILabel!
    var g :GridPassView? = nil
    var screenSize: CGRect? = nil
    let blueFontColor = UIColor(red: 240/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    let greenFontColor = UIColor(red: 120/255.0, green: 100/255.0, blue: 75/255.0, alpha: 1.0)
    let paddingTop :Int = 25;
    let paddingLeft :Int = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after // Dispose of any resources that can be recreated.
        /*        let input = "super"
         let xdata = input.data(using: String.Encoding.utf8)
         var us: UserShape = UserShape(clearText: "super")
         
         let outData = sha256(data: xdata!)
         var outputString = String(data: outData, encoding: String.Encoding.ascii)
         
         outputMsg.text = us.finalHash
         counterMsg.text = String(us.finalHashLength) + " bytes"
         //outputMsg.text = "super star is here"
         //view.addSubview(firstView)
         */
        screenSize = UIScreen.main.bounds
        
        addSubView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func ClearGridButtonClicked(_ sender: AnyObject) {
        clearGrid()
    }
    
    func addSubView(){
        // screenSize?.width)!*0.95
        // screenSize?.height)!*0.5
        let gridPassWidth :Int = Int(((screenSize?.width)!*0.95))
        let gridPassHeight :Int = Int(((screenSize?.width)!*0.95))
        let firstFrame : CGRect = CGRect(x:paddingLeft, y:paddingTop, width: gridPassWidth, height: gridPassHeight)
        
        
        g = GridPassView(frame: firstFrame, width:gridPassWidth, height: gridPassHeight)
        
        g?.tag = 100
        view.addSubview(g!)
    }
    
    func clearGrid(){
        g = nil;
        if let viewWithTag = self.view.viewWithTag(100){
            viewWithTag.removeFromSuperview()
        }
        addSubView()
    }
    
    func genUserHash(){
        //let hg: HashGenerator = HashGenerator(clearText: userClearText.text! +  (g?.outValue)!)
        let hg: HashGenerator = HashGenerator(clearText: (g?.outValue)!)
    //    outputMsg.text = hg.finalHash
        HashLabelOutlet.text = hg.finalHash
        UIPasteboard.general.string = hg.finalHash
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            genUserHash()
    }

}

