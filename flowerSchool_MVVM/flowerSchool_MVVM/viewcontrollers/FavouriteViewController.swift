//
//  FavouriteViewController.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class FavouriteViewController: UIViewController {

    static let identifier = "FavouriteViewController"
    private let viewmodel = PlantViewModel()
    let bag = DisposeBag()
    let db = RealmService.shared
    
    @IBOutlet weak var btnRecent: UIButton!
    @IBOutlet weak var btnOld: UIButton!
    @IBOutlet weak var btnColor: UIButton!
    @IBOutlet weak var btnAlbum: UIButton!
    @IBOutlet weak var collectionViewFavourite: UICollectionView!
    
    //To calculate flowlayout
    let numberOfItemsPerRow: CGFloat = 2.0
    let spacing : CGFloat = 8 // leading 5 + Trailing 5 of cardview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRecent.layer.cornerRadius = 5
        setupCollectionView()
        
        collectionViewFavourite.delegate = self
        collectionViewFavourite.register(UINib(nibName: String(describing: FavouriteCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavouriteCollectionViewCell.self))
       
        initDataObservation()
        viewmodel.requestFavourite()
        //viewmodel.requestData()
    }
    
    func setupCollectionView(){
        //Flowlayout
        let totalPadding: CGFloat = numberOfItemsPerRow * spacing
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsPerRow
        let layout = collectionViewFavourite.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func initDataObservation(){
        
        
        viewmodel.favPlantObs
            .observeOn(MainScheduler.instance)
            .bind(to: collectionViewFavourite.rx.items){collectionView , index , item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavouriteCollectionViewCell.self), for: IndexPath(row : index ,section: 0)) as! FavouriteCollectionViewCell
                cell.mData = item
                return cell
            }.disposed(by: bag)
        
    }
    
}

extension FavouriteViewController : UICollectionViewDelegate{

}
