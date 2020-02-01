//
//  CollectionViewController.swift
//  ImageTest
//
//  Created by Максим Томилов on 26.01.2020.
//  Copyright © 2020 Tomily. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    var allImage : [Image] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadIndicator.startAnimating()
        API.loadImage{imagesArr, err in
            if let images = imagesArr {
                self.allImage = images
                DispatchQueue.main.async{
                    self.collectionView.reloadData()
                    self.loadIndicator.stopAnimating()
                }
            }
        }
    }
    

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let image = allImage[indexPath.row]
        if let url = URL(string: image.largeImageURL) {
            cell.imageView.downloadImage(from: url)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else {return}
            var image: Image
            image = allImage[indexPath.row]
            let openImageVC = segue.destination as! ImageViewController
            openImageVC.imageShow = image
        }
    }

}
