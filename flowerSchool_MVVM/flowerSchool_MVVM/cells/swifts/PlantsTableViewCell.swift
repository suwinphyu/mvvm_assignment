//
//  PlantsTableViewCell.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import SDWebImage
import Realm
import RxRealm

class PlantsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var plantView: CardView!
    @IBOutlet weak var imgViewPlantPhoto: UIImageView!
    @IBOutlet weak var imgViewFavourite: UIImageView!
    @IBOutlet weak var lblPlantName: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    let db = RealmService.shared
    var plantInfo =  PlantVO()
    var isFavourite  =  false
    
    @IBOutlet weak var leftPlantView: UIView!
    var mData : PlantVO? {
        didSet{
            if let data = mData {
                lblPlantName.text = data.plantName
                imgViewPlantPhoto.sd_setImage(with: URL(string: data.plantPhoto ), completed: nil)
                lblUserName.text = data.uploadedUser?.name ?? "John T.Lord"
                imgViewProfile.sd_setImage(with: URL(string: data.uploadedUser!.userPhoto), placeholderImage: UIImage(named: "pp"))
                
                plantInfo = data
                isFavourite = PlantVO.isFavourite(plantId: data.plantId , realm: db.realm)
                if isFavourite == true {
                    self.imgViewFavourite.image = UIImage(named:"liked")
                }else {
                    self.imgViewFavourite.image = UIImage(named:"unlike")
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        plantView.layer.cornerRadius = 1
       // plantView.layer.maskedCorners = [.layerMinXMaxYCorner]

        leftPlantView.layer.cornerRadius = 30
      //  leftPlantView.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        imgViewProfile.layer.cornerRadius = imgViewProfile.frame.width/2
       // initFavouriteView()
        
        imgViewFavourite.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickDrawer))
        imgViewFavourite.addGestureRecognizer(tapGesture)
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
 
    @objc func onClickDrawer(_ sender : Any){
        //print(plantInfo)
        if isFavourite == true {
            isFavourite = false
            self.imgViewFavourite.image = UIImage(named:"unlike")
            db.delete(object:plantInfo)
            
        } else {
            isFavourite = true
            self.imgViewFavourite.image = UIImage(named:"liked")
            db.create(object: plantInfo)

        }
    }

}
