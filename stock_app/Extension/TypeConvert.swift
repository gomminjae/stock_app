//
//  TypeConvert.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation


extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}


extension Date {
    
    func toString() -> String {
        let dataFormatter = DateFormatter()
        return dataFormatter.string(from: self)
    }
}

