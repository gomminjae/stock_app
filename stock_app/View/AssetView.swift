//
//  AssetView.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit


class AssetView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func commonInit() {
        let view = Bundle.main.loadNibNamed(AssetView.reusableIdentifier, owner: self, options: nil)!.first as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    
    
    
}
