//
//  FavouriteCollectionViewCell.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgViewFavouriteImage: UIImageView!
    
    var mData : PlantVO? {
        didSet{
            if let data = mData {
                     imgViewFavouriteImage.sd_setImage(with: URL(string: data.plantPhoto ?? "placeholder"), completed: nil)
                
            }
            
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
