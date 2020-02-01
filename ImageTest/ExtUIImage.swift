//
//  ExtUIImage.swift
//  ImageTest
//
//  Created by Максим Томилов on 27.01.2020.
//  Copyright © 2020 Tomily. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
    
   func downloadImage(from url: URL) {

    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage{
        self.image = imageFromCache
        return
    }
    
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            let rawImage = UIImage(data: data)
            self.image = rawImage
            if rawImage != nil {
                imageCache.setObject(rawImage!, forKey: url as AnyObject)
            }
         }
        return
      }

   }
}
