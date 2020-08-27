//
//  EmptyView.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation
import SnapKit

extension UITableView {
    func setEmptyView(title: String, message: String, image: UIImage) {
        let emptyView: UIView = {
            let view = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
            //view.backgroundColor = .blue
            
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.textColor = .white
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            return label
        }()
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .lightGray
            label.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(emptyView.snp.centerY)
            $0.centerX.equalTo(emptyView.snp.centerX)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalTo(emptyView.snp.left).offset(20)
            $0.right.equalTo(emptyView.snp.right).offset(-20)
        }
        
        self.backgroundView = emptyView
        
    }
    
    func restore() {
        self.backgroundView = nil
    }
}


