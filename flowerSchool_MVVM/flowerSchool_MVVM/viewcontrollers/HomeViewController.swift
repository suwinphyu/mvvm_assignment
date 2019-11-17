//
//  HomeViewController.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import LGSideMenuController
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    static let identifier = "HomeViewController"
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var tableViewPlant: UITableView!
    
    
    private let viewmodel = PlantViewModel()
    let bag = DisposeBag()
    var mPlantList : [PlantVO] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageView.layer.cornerRadius = 30
        navigationDrawer()
        
        tableViewPlant.register(UINib(nibName: String(describing: PlantsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PlantsTableViewCell.self))
        
       initDataObservation()
       viewmodel.requestData()
       
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        initDataObservation()
//        viewmodel.requestData()
//        navigationDrawer()
//    }
    
    func navigationDrawer(){
       
        sliderImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickDrawer))
        sliderImageView.addGestureRecognizer(tapGesture)

    }
    
    @objc func onClickDrawer(){
        
      // let vc = (UIApplication.shared.keyWindow!.rootViewController) as! LGSideMenuController
        let vc = UIApplication.shared.windows.first!.rootViewController as! LGSideMenuController
        vc.showLeftViewAnimated()
         
    }

    
    private func initDataObservation(){
        
        // RxCocoa
        viewmodel.dataObs
            .observeOn(MainScheduler.instance)
            .bind(to: tableViewPlant.rx.items){tableview , index , item in
                let cell = tableview.dequeueReusableCell(withIdentifier: String(describing: PlantsTableViewCell.self), for: IndexPath(row : index ,section: 0)) as! PlantsTableViewCell
                cell.mData = item
                return cell
            }.disposed(by: bag)
        
        
        
        Observable.zip(tableViewPlant.rx.itemSelected,tableViewPlant.rx.modelSelected(PlantVO.self)).bind{
            indexPath , model in
            //self.tableViewPlant.selectRow(at: indexPath, animated: true, scrollPosition: 0)
            self.tableViewPlant.deselectRow(at: indexPath, animated: true)
           // print("Selected" + model.uploadedUser!.name)
             }.disposed(by: bag)
        
        
        tableViewPlant.rx.modelSelected(PlantVO.self)
            .subscribe(onNext : { data  in
               
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewcontroller = storyboard.instantiateViewController(withIdentifier: PlantDetailViewController.identifier) as! PlantDetailViewController
                self.present(viewcontroller, animated: true, completion: nil)
                viewcontroller.imgViewPlantBackground.sd_setImage(with: URL(string:data.plantPhoto ), completed: nil)
                viewcontroller.lblPlantName.text = data.plantName
                viewcontroller.lblPlantDescription.text = data.plantDescription
 
                viewcontroller.lblUserName.text = data.uploadedUser?.name ?? "John T.Lord"
                viewcontroller.imgViewUserProfile.sd_setImage(with: URL(string: data.uploadedUser!.userPhoto), placeholderImage: UIImage(named: "pp"))
              
            }).disposed(by: bag)
    }
    
    func bindPlant(plant : [PlantVO]){
        //self.mCategoryList = category
        self.tableViewPlant.reloadData()
        
    }

}
