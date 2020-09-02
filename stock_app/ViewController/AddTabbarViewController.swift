//
//  AddTabbarViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import STTabbar

class AddTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myTabbar = tabBar as? STTabbar {
            myTabbar.itemPositioning = .fill

            
            myTabbar.centerButtonActionHandler = {
                guard let vc = self.storyboard?.instantiateViewController(identifier: "addPortfolio") else { return }
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    override var shouldAutorotate: Bool {
           return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           return .portrait
    }
    


    

}
