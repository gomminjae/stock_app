//
//  Category.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation


enum Category: String,CaseIterable {
    case tech = "기술"
    case bio = "바이오"
    case entertainment = "엔터테이먼트"
    case finance = "금융"
    case transport = "운송"
    case material = "원자재"
    case energy = "에너지"
    case chemistry = "화학"
    
    var index: Int {
        switch self {
        case .tech: return 0
        case .bio: return 1
        case .entertainment: return 2
        case .finance: return 3
        case .transport: return 4
        case .material: return 5
        case .energy: return 6
        case .chemistry: return 7
        }
    }
}

extension Category {
    
    static func toCategory(string: String) -> Category? {
        switch string {
        case "기술":
            return .tech
        case "바이오":
            return .bio
        case "엔터테이먼트":
            return .entertainment
        case "금융":
            return .finance
        case "운송":
            return .transport
        case "원자재":
            return .material
        case "에너지":
            return .energy
        case "화학":
            return .chemistry
        default:
            return nil
        }
    }
}
