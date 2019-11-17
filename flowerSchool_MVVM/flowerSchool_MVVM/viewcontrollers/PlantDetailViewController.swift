//
//  PlantDetailViewController.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift
import RealmSwift

class PlantDetailViewController: UIViewController {

    static let identifier = "PlantDetailViewController"
    private let viewmodel = PlantViewModel()
    let bag = DisposeBag()
    var selectedPlant : String = ""
    var isFavourite = false
    let db = RealmService.shared
    
    var tips : [TipsVO] = []
    
    
    @IBOutlet weak var lblPlantId: UILabel!
   @IBOutlet weak var imgViewFavourite: UIImageView!
    @IBOutlet weak var viewFavouriteicon: UIView!
    @IBOutlet weak var imgViewPlantBackground: UIImageView!
    @IBOutlet weak var viewPlantDetail: UIView!
    @IBOutlet weak var collectionViewTips: UICollectionView!
    @IBOutlet weak var lblPlantDescription: UILabel!
    @IBOutlet weak var lblPlantName: UILabel!    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgViewUserProfile: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        collectionViewTips.delegate = self
        //collectionViewTips.dataSource = self
        collectionViewTips.register(UINib(nibName: String(describing: TipsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TipsCollectionViewCell.self))
       
        initDataObservation()
        viewmodel.requestData()
    }
    
    private func setupUI(){
        viewFavouriteicon.layer.cornerRadius = 20
    
        viewPlantDetail.layer.cornerRadius = 35
        viewPlantDetail.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        
        viewPlantDetail.layer.borderWidth = 1
        viewPlantDetail.layer.borderColor = UIColor.black.cgColor
        
        imgViewUserProfile.layer.cornerRadius = imgViewUserProfile.frame.width/2
        
 
    }

    override func viewWillAppear(_ animated: Bool) {
        if let plantId = lblPlantId.text{
            selectedPlant = String(plantId)
            
        }
        
        isFavourite = PlantVO.isFavourite(plantId: selectedPlant , realm: db.realm)
        if isFavourite == true {
            self.imgViewFavourite.image = UIImage(named:"liked")
        }else {
            self.imgViewFavourite.image = UIImage(named:"unlike")
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnShare(_ sender: Any) {
    }
    
    private func initDataObservation(){
        

//
//        // RxCocoa
//        viewmodel.tipsObs
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext:{ data in
//                self.tips = data
//                self.collectionViewTips.reloadData()
//            })
//            .disposed(by: bag)
        
        // RxCocoa
        viewmodel.dataObs
            .observeOn(MainScheduler.instance)
            .bind(to: collectionViewTips.rx.items){tableview , index , item in
                let cell = tableview.dequeueReusableCell(withReuseIdentifier: String(describing: TipsCollectionViewCell.self), for: IndexPath(row : index ,section: 0)) as! TipsCollectionViewCell
                cell.mData = item
                return cell
            }.disposed(by: bag)
        
    }
    
}

extension PlantDetailViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 207)
    }
}
//
//extension PlantDetailViewController :UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TipsCollectionViewCell.self), for: indexPath ) as! TipsCollectionViewCell
//        item.mData = tips
//        return item
//    }
//
//
//}
