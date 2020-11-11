//
//  UserKWDTableViewCell.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/17.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class UserKWDTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgViewWidth: NSLayoutConstraint!
    @IBOutlet var searchWordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
