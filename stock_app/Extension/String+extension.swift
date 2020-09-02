//
//  String+extension.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/31.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation

extension String {
    public var withoutHtml: String {
        
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}
