//
//  KKOManager.swift
//  KaKao_SearchAppStore
//
//  Created by 50127348 on 2020/08/18.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class KKOManager: NSObject {

    static let shared = KKOManager()
    
    open var loadingView : LoadingView?
    
    func screenLock() {
        self.screenLockInit()
        DispatchQueue.main.async {
            if let _loadingView = self.loadingView {
                _loadingView.startLoading()
                _loadingView.isHidden = false
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }

    func screenUnLock() {
        self.screenLockInit()
        DispatchQueue.main.async {
            if let _loadingView = self.loadingView {
                _loadingView.stopLoading()
                _loadingView.isHidden = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    func screenLockInit() {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = LoadingView.fromNib()
            }
        }
    }

    func getStarString(_ avgInt: Int) -> String {
        var returnStr: String = ""
        for _ in 0..<avgInt {
            returnStr = returnStr + "★"
        }
        return returnStr
    }
}
