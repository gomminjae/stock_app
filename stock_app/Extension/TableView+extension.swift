//
//  TableView+extension.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/28.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit


extension UITableView {
    
    func setupTableView(for cell: UITableViewCell) {
        let nibName = UINib(nibName: cell.reuseIdentifier!, bundle: nil)
        self.register(nibName, forCellReuseIdentifier: cell.reuseIdentifier!)
    }
}


extension UICollectionView {
    
    func setupTableView(for cell: UICollectionViewCell) {
        let nibName = UINib(nibName: cell.reuseIdentifier!, bundle: nil)
        self.register(nibName, forCellWithReuseIdentifier: cell.reuseIdentifier!)
    }
}
