//
//  HashGenerator.swift
//  CYaPass
//
//  Created by roger deutsch on 10/9/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import Foundation

class HashGenerator{

    var clearText: String
    var finalHash: String
    var finalHashLength: Int

    init(clearText: String) {
        self.clearText = clearText
        self.finalHash = ""
        self.finalHashLength = 0
        genHash()
    }

    func genHash(){
        let xdata = clearText.data(using: String.Encoding.utf8)
        let hashBytes: [UInt8] = sha256AsBytes(clearTextData:xdata!)
    
        for item in hashBytes{
            let h1 : String = String(format: "%02x", item)
            finalHash = finalHash + h1 //String(item, radix:16)
            finalHashLength += 1
        }
        if (CyaSettings.isMaxLengthOn){
            
            let index = finalHash.index(finalHash.startIndex, offsetBy: CyaSettings.maxPassLength)
           
            finalHash = finalHash.substring(to: index)
        }
        
        if (CyaSettings.isUppercaseOn){
            finalHash = finalHash.uppercased();
           /* var startIndex : Int = 0
            for count in 0...(finalHash.characters.count - 1){
                switch (finalHash.characters.){
                case "1": break
                case "2": break
                case "3": break
                case "4": break
                case "5": break
                case "6": break
                case "7": break
                case "8": break
                case "9": break
                case "0": break
                default :
                    {
                        startIndex = startIndex + 1
                        continue
                    }
                }
                
            }
            let idx = finalHash.index(finalHash.startIndex, offsetBy:3)
            finalHash = finalHash.stringByReplacingCharactersInRange(
                finalHash.startIndex..<finalHash.startIndex.advancedBy(3),
                withString: "wh")*/
        }
        
    }

    func sha256AsBytes(clearTextData : Data) -> [UInt8] {
        var hashBytes = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        clearTextData.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(clearTextData.count), &hashBytes)
        }
        return hashBytes
    }
}
