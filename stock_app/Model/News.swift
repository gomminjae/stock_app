//
//  News.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation


struct News: Codable {
    let title: String
    let link: String
    let content: String
    let pubDate: String
    let originalLink: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case link = "link"
        case content = "description"
        case pubDate = "pubDate"
        case originalLink = "originallink"
    }
}


struct Response: Codable {
    let resultCount: Int
    let news: [News]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "total"
        case news = "items"
    }
    
 
}
