//
//  DetailViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/28.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit


protocol DetailStockDelegate: class {
    func SendStockData(data: Stock)
}


class DetailViewController: UIViewController {
    
    
    var stock: Stock?
    weak var delegate: DetailStockDelegate?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  

}
