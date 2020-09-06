//
//  StockViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/05.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    var stockName = String()

    @IBOutlet weak var stockNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockNameLabel.text = stockName

        // Do any additional setup after loading the view.
    }
    

    

}
