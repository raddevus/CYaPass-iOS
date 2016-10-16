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
            finalHash = finalHash + String(item, radix:16)
            finalHashLength += 1
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
