//
//  LoadingBar.swift
//  KaKao_SearchAppStore
//
//  Created by 50127348 on 2020/08/18.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var indicatorImageView: UIImageView!
    
    class func instantiateFromNib() -> LoadingView {
        return Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?[0] as! LoadingView
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame = app.window!.frame
        UIApplication.shared.keyWindow?.addSubview(self)
        
        self.setIndicatorImages()
    }
    
    func startLoading() {
        self.isHidden = false
        indicatorImageView.startAnimating()
    }
    
    func stopLoading() {
        self.isHidden = true
        indicatorImageView.stopAnimating()
    }
    
    func setIndicatorImages() {
        var indicatorImages : [UIImage] = []
        
        for i in 1...4 {
            
            let imageNm = "loadingA_0\(i)"//"loading_icon_0\(i)"
            guard let img = UIImage.init(named:imageNm) else { return }
            
            indicatorImages.append(img)
        }
        
        indicatorImageView.animationImages = indicatorImages
        indicatorImageView.animationDuration = 2.0
        indicatorImageView.animationRepeatCount = 0
    }
}

extension LoadingView {
    class func fromNib<T: LoadingView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
