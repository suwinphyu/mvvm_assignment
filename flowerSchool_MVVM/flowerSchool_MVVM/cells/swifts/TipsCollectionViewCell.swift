//
//  TipsCollectionViewCell.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit


class TipsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgViewTips: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTipsValue: UILabel!
    
    var mData : PlantVO? {
        didSet{
            if let data = mData {
                
            
                if (data.tips?.value(forKey: "temperature") != nil){
                    lblTitle.text = "Temperature"
                    lblTipsValue.text = data.tips?.temperature
                    imgViewTips.image = UIImage.init(imageLiteralResourceName: "icons8-temperature_sensitive")
                }
                if (data.tips?.value(forKey: "light") != nil){
                    
                    lblTitle.text = "light"
                    lblTipsValue.text = data.tips?.light
                    imgViewTips.image = UIImage.init(imageLiteralResourceName: "icons8-sun")
                    
                }
                
                if (data.tips?.value(forKey: "placement") != nil) {
                    
                    lblTitle.text = "placement"
                   lblTipsValue.text = data.tips?.placement
                    imgViewTips.image = UIImage.init(imageLiteralResourceName: "icons8-replace")
                    
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
