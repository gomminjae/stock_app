//
//  reusableIdentifier+extension.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation


extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
