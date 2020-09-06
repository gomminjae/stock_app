//
//  Stock.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation
import RealmSwift



class StockList: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var saveDate: Date = Date()
    
    let stocks = List<Stock>()
    
    // 고유한 값으로 객체를 식별하는 역할!
    @objc dynamic var uuid: String = UUID().uuidString
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}


@objcMembers class Stock: Object {
    
    dynamic var stockName: String = ""
    dynamic var buy: Int = 0
    dynamic var sell: Int = 0
    dynamic var amount: Int = 0
    dynamic var rate: Double = 0.0
    dynamic var saveDate = Date()
    dynamic var category: String = ""
    
    let info = List<String>()
    
    let list = LinkingObjects(fromType: StockList.self, property: "stocks")
    
}
