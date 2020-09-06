//
//  IssueCell.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: { self.contentView.layoutIfNeeded() })
    }
    
}

