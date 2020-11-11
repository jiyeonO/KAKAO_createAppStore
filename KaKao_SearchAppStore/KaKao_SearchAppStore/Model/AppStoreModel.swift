//
//  AppStoreModel.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import Foundation

struct AppStoreModel {
    var advisories: [String]?
    var supportedDevices: [String]?
    var isGameCenterEnabled: Bool = false
    
    var screenshotUrls: [String]?
    var screenshotUrlDatas: [Data]?
    var ipadScreenshotUrls: [String]?
    var appletvScreenshotUrls: [String]?
    var artworkUrl60: String?
    var artworkUrl512: String?
    var artworkUrl100: String?
    var artistViewUrl: String?
    
    var features: [String]?
    var kind: String?
    var currentVersionReleaseDate: String?
    var primaryGenreName: String?
    var sellerName: String?
    var isVppDeviceBasedLicensingEnabled: Bool = false
    var primaryGenreId: Int?
    var minimumOsVersion: String?
    var formattedPrice: String?
    
    var releaseNotes: String?
    var releaseDate: String?
    var trackId: Int?
    var trackName: String?
    var genreIds: String?
    var trackCensoredName: String?
    var languageCodesISO2A: [String]?
    
    var fileSizeBytes: String?
    var sellerUrl: String?
    
    var contentAdvisoryRating: String?
    var averageUserRatingForCurrentVersion: Double?
    var userRatingCountForCurrentVersion: Int?
    var averageUserRating: Double?
    var trackViewUrl: String?
    var trackContentRating: String?
    var description: String?
    
    var price: Double?
    var genres: [String]?
    var artistId: Int?
    var artistName: String?
    var currency: String?
    var bundleId: String?
    var version: String?
    var wrapperType: String?
    var userRatingCount: Int?
    
    init() {
        isGameCenterEnabled = false
        isVppDeviceBasedLicensingEnabled = false
    }
}

/*
"resultCount":29,
   "results":[
      {
         "advisories":[],
         "supportedDevices":[],
         "isGameCenterEnabled":false,
         "screenshotUrls":[],
         "ipadScreenshotUrls":[],
         "appletvScreenshotUrls":[],
         "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/bb/cd/cf/bbcdcfa6-19bc-48fe-2e3e-54abb5ba44da/source/60x60bb.jpg",
         "artworkUrl512":"https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/bb/cd/cf/bbcdcfa6-19bc-48fe-2e3e-54abb5ba44da/source/512x512bb.jpg",
         "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/bb/cd/cf/bbcdcfa6-19bc-48fe-2e3e-54abb5ba44da/source/100x100bb.jpg",
         "artistViewUrl":"https://apps.apple.com/kr/developer/kakao-corp/id362057950?uo=4",
         "features":["iosUniversal"],
         "kind":"software",
         "currentVersionReleaseDate":"2020-08-06T02:58:40Z",
         "primaryGenreName":"Social Networking",
         "sellerName":"Kakao Corp.",
         "isVppDeviceBasedLicensingEnabled":true,
         "primaryGenreId":6005,
         "minimumOsVersion":"11.0",
         "formattedPrice":"무료",
         "releaseNotes":"[v8.9.8] 더 좋은 앱을 만들기 위해 정기적으로 업데이트가 진행됩니다. 버그 수정 및 앱 안정성이 향상된 최신 버전을 이용하시기 바랍니다.",
         "releaseDate":"2010-03-18T03:17:28Z",
         "trackId":362057947,
         "trackName":"카카오톡 KakaoTalk",
         "genreIds":["6005", "6007"],
         "trackCensoredName":"카카오톡 KakaoTalk",
         "languageCodesISO2A":["EN", "FR", "DE", "ID", "IT", "JA", "KO", "PT", "RU", "ZH", "ES", "TH", "ZH", "TR", "VI"],
         "fileSizeBytes":"499325952",
         "sellerUrl":"https://www.kakaocorp.com/service/KakaoTalk",
         "contentAdvisoryRating":"4+",
         "averageUserRatingForCurrentVersion":2.833709999999999951114659779705107212066650390625,
         "userRatingCountForCurrentVersion":74278,
         "averageUserRating":2.833709999999999951114659779705107212066650390625,
         "trackViewUrl":"https://apps.apple.com/kr/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1-kakaotalk/id362057947?uo=4",
         "trackContentRating":"4+",
         "description":"* 업데이트를 하기 전에 항상 폰 백업 혹은 '이메일 계정 연결', '친구목록 내보내기' 등으로 중요한 데이터를 보관하시기를 권장합니다.",
         "price":0.00,
         "genres":[
            "소셜 네트워킹",
            "생산성"
         ],
         "artistId":362057950,
         "artistName":"Kakao Corp.",
         "currency":"KRW",
         "bundleId":"com.iwilab.KakaoTalk",
         "version":"8.9.8",
         "wrapperType":"software",
         "userRatingCount":74278
      },
*/
