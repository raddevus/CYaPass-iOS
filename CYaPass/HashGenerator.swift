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
            finalHash = addUppercase(target: &finalHash)
           
        }
        
    }
    
    func findFirstLetterIndex (_ phrase: String, foundChar : inout Character) -> Int{
        var charCounter : Int = 0
        for c in phrase.characters{
            // print(c, terminator:"")
            if ((c >= "A" && c <= "Z") || (c >= "a" && c <= "z") ){
                // print()
                foundChar = c
                return charCounter
            }
            charCounter += 1
        }
        
        return -1
    }
    
    func addUppercase(target : inout String) -> String{
        // takes the original string (target) and
        // returns the string with the uppercase letter
        // or, if there are no letters to uppercase returns the
        // original unchagned string.
        var outChar : Character = "0"
        let idxFind = findFirstLetterIndex( target, foundChar: &outChar)
        
        if (idxFind > -1){
            // if idxFind is greater than -1 then the method found a letter
            target.remove(at: target.index(target.startIndex, offsetBy:idxFind))
            //print (target)
            
            // Generate the replaceString using the outChar
            let replaceString : String = String(outChar)
            let replaceChar : Character = Character(replaceString.uppercased())
           
            target.insert( replaceChar, at: target.index(target.startIndex, offsetBy:idxFind))
        }
        return target
    }

    func sha256AsBytes(clearTextData : Data) -> [UInt8] {
        var hashBytes = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        clearTextData.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(clearTextData.count), &hashBytes)
        }
        return hashBytes
    }
}
