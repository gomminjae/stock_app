//
//  Stock.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation
import RealmSwift
 

@objcMembers class Stock: Object {
    dynamic var stockName: String = ""
    dynamic var buy: Int = 0
    dynamic var sell: Int = 0
    dynamic var amount: Int = 0
    dynamic var rate: Double = 0.0
    dynamic var date = Date()
    
    dynamic var category = Category.tech.rawValue
    
    var setCategory: Category {
        get { return Category(rawValue: category) ?? .tech}
        set { category = newValue.rawValue }
    }
    
}
