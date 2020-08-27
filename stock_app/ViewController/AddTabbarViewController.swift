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

    }
    override var shouldAutorotate: Bool {
           return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           return .portrait
    }

    

}
