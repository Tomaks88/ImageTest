//
//  ImageViewController.swift
//  ImageTest
//
//  Created by Максим Томилов on 29.01.2020.
//  Copyright © 2020 Tomily. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var openImage: UIImageView!
    @IBOutlet weak var loadImage: UIActivityIndicatorView!
    @IBOutlet weak var infoImage: UILabel!
    
    var imageShow: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage.startAnimating()
        infoImage.text = "Пользователь: " + (imageShow?.user ?? "")
        if imageShow != nil {
            if let url = URL(string: imageShow?.largeImageURL ?? "") {
                self.openImage.downloadImage(from: url)
                DispatchQueue.main.async(execute: {
                    self.loadImage.stopAnimating()
                })
            }
        }
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [imageShow?.largeImageURL ?? ""], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
}
