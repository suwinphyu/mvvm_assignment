//
//  navigateToDetails.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func navigateToHome()  {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main  )
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
       // vc?.mData =
        if let viewController = vc {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
