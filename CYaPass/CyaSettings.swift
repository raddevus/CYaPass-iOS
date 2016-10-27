//
//  CyaSettings.swift
//  CYaPass
//
//  Created by roger deutsch on 10/23/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import Foundation

class CyaSettings {
    public var isMaxLengthOn : Bool = false
    
    public var maxPassLength : Int = 0
    
    public var isUppercaseOn : Bool = false
    
    public var isSpecialCharsOn : Bool = false
    public var specialChars : String = ""
    public var shapeValue: String!
    public var mainView :MainViewController
    
    init (_ mainView : MainViewController){
        self.mainView = mainView
    }
}
