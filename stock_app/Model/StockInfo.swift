//
//  StockInfo.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/31.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation
import RealmSwift


struct StockInfo {
    
    let title: String
    let subtitle: String
    let info: String
    let type: StockInfoType
    
}


enum StockInfoType {
    case invested
    case portfolio
    
    var title: String {
        
        switch self {
        case .invested: return "내가 투자한 종목"
        case .portfolio: return "관심 종목"
        }
    }
}
