//
//  LoginViewController.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LGSideMenuController

class LoginViewController: UIViewController {

    static let identifier = "LoginViewController"
    
    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    private let userViewModel = UserViewModel()
    let bag = DisposeBag()
    var userInfo : [UserVO] = []
    var inputEmail : String = ""
    var inputPassword : String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

       

    }
    
    func setupUI(){
 
        viewEmail.layer.cornerRadius = 30
        viewEmail.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        viewEmail.layer.borderWidth = 1
        viewEmail.layer.borderColor = UIColor.black.cgColor
        
        viewPassword.layer.cornerRadius = 30
        viewPassword.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        viewPassword.layer.borderWidth = 1
        viewPassword.layer.borderColor = UIColor.black.cgColor
        
        viewButton.layer.cornerRadius = 30
        viewButton.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }

    
    
    @IBAction func btnLogin(_ sender: Any) {
        inputEmail = txtFieldEmail.text ?? ""
        inputPassword = txtFieldPassword.text ?? ""
      
        if(inputEmail.isEmpty || inputPassword.isEmpty){
            Dialog.showAlert(viewController: self, title: "Alert!", message: "Required for Email or Password")
        } else {
            userViewModel.requestData(email: inputEmail, password: inputPassword)
            UserDefaults.standard.set(true, forKey: "IS_USER_LOGIN")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
            self.present(viewcontroller, animated: true, completion: nil)
        
        }
        
    }
    

    
    @IBAction func btnForgetPassword(_ sender: Any) {
        
    }
  
}
