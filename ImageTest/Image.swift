//
//  Image.swift
//  ImageTest
//
//  Created by Максим Томилов on 21.01.2020.
//  Copyright © 2020 Tomily. All rights reserved.
//

import Foundation


class Image {
    
    var largeImageURL : String = ""
    var user : String = ""
    
    convenience init(data: JSON){
        self.init()
        largeImageURL = data["largeImageURL"] as! String
        user = data["user"] as! String
    }
}
