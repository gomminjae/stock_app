//
//  HeaderView.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/31.
//  Copyright © 2020 gommj_Dev. All rights reserve


import UIKit


class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        guard let view = Bundle.main.loadNibNamed(HeaderView.reusableIdentifier, owner: self, options: nil)!.first as? UIView else { return }
        
        view.frame = self.bounds
        //addSubView(view)
        
    }
}
