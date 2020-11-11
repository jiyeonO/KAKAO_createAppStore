//
//  ImageViewExtension.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/17.
//  Copyright © 2020 오지. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromURL(_ urlString: String, placeholder: UIImage?,  completioin: @escaping () -> ()) {
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            DispatchQueue.main.async(execute: { () -> Void in
                if let _data = data {
                    let image = UIImage(data: _data)
                    
                    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 1.0)
                    image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
                    let newImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    self.image = newImage
                    self.setNeedsLayout()
                    
                    completioin()
                }
            })
        }
        
        task.resume()
    }
}
