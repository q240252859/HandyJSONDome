//
//  UploadFileModule.swift
//  chbtc
//
//  Created by mqt on 16/3/12.
//  Copyright © 2016年 bitbank. All rights reserved.
//

import UIKit

class UploadFileModule: NSObject {
    var data: Data!
    var fileName: String!
    var name: String!
    var mimeType: String!
    
    convenience init(data: Data, name: String, fileName: String, mimeType: String) {
        self.init()
        self.data = data
        self.fileName = fileName
        self.name = name
        self.mimeType = mimeType
    }
}
