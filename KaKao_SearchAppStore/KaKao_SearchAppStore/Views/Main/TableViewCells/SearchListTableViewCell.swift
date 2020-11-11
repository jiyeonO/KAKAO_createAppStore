//
//  SearchListTableViewCell.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

protocol openButtonTouchDelegate {
    func openButtonTouchUpInside(_ index: IndexPath)
}

class SearchListTableViewCell: UITableViewCell {
    
    var delegate: SearchMainVC?
    var indexPath: IndexPath?
    
    @IBOutlet weak var artworkIV: UIImageView!
    @IBOutlet weak var trackNameLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var avgUserRatingLbl: UILabel!
    @IBOutlet weak var userRatingCountLbl: UILabel!
    
    @IBOutlet var openBtn: UIButton!
    @IBOutlet var screenshotIVs: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        artworkIV.layer.cornerRadius = 10
        openBtn.layer.cornerRadius = 12
        for img in screenshotIVs {
            img.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func openDetailButtonTouchUp(_ sender: UIButton) {
        if let _indexPath = indexPath {
            delegate?.openButtonTouchUpInside(_indexPath)
        }
    }
    
}
