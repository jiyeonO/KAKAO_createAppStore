//
//  KKOConstants.swift
//  SearchAppStore_KAKAO
//
//  Created by 오지 on 2020/08/14.
//  Copyright © 2020 오지. All rights reserved.
//

import Foundation
import UIKit

let app = UIApplication.shared.delegate as! AppDelegate

let USER_KWD_LIST = "USER_KWD_LIST"


// 검색창 화면 타입
enum SearchViewType: Int {
    case main          // 검색 메인
    case filtered      // 검색 리스트
    case searchList    // 상세 리스트
}

func safeAreaTopCheck() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    } else {
        return 0
    }
}

func safeAreaBottomCheck() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    } else {
        return 0
    }
}

func setUserDefaultArr(key: String, value: Array<Any>) {
    let userDefault: UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func getUserDefaultArr(key: String) -> Array<Any> {
    let userDefault: UserDefaults = UserDefaults.standard
    guard let value = userDefault.array(forKey: key) else { return [] } // count로 판단
    return value
}

func getUrlImage(_ urlString: String) -> UIImage? {
    do {
        if let url = URL(string: urlString) {
            let data = try Data(contentsOf: url)
            
            return UIImage(data: data)!
        }
    } catch {
        debugPrint("getURLImageError: \(error.localizedDescription)")
    }
    return nil
}

