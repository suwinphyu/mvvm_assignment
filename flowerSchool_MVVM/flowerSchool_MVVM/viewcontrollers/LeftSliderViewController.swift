//
//  LeftSliderViewController.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LeftSliderViewController: UIViewController {

    static let identifier = "LeftSliderViewController"
    
    @IBOutlet weak var profileBackgroundImgView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
   
    private let userViewModel = UserViewModel()
    let bag = DisposeBag()
    var userInfo : [UserVO] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBackgroundImgView.alpha = 0.7
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        lblUserName.text = "John T.Lord"
        
       
   
    }
    

    @IBAction func btnFavourite(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: FavouriteViewController.identifier) as! FavouriteViewController
        self.present(viewcontroller, animated: true, completion: nil)
    }
    

    @IBAction func btnLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IS_USER_LOGIN")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as! LoginViewController
        self.present(viewcontroller, animated: true, completion: nil)
    }

}
