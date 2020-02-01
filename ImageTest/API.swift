//
//  API.swift
//  ImageTest
//
//  Created by Максим Томилов on 21.01.2020.
//  Copyright © 2020 Tomily. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String : Any]


class API {
    
    static var baseURL: String {
        "https://pixabay.com/api/?key=14975843-11c82766dcb8b38c4cd451f26"
    }
    
    static func loadImage(complection: @escaping ([Image]?, NSError?) -> Void){
        AF.request(baseURL, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON {responce in
                switch responce.result {
                case .success(let value) :
                    let jsonData = value as! JSON
                    let imageData = jsonData["hits"] as! [JSON]
                    var images = [Image]()
                    for image in imageData {
                        images.append(Image (data: image as! JSON))
                    }
                        complection(images, nil)
                    
                case .failure(let error) :
                    complection(nil, error as NSError)
                }
            }
        }
} 
