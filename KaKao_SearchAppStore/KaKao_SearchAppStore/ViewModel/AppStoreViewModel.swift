//
//  AppStoreViewModel.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import Foundation

class AppStoreViewModel {
    var appStoreList: [AppStoreModel]?
    var appStoreSearchName: [String]?
    var resultCount: Int = 0
    var network: Network?
    
    init(_ network: Network) {
        self.network = network
    }
    
    func getSearchAppName(_ name: String, completion: @escaping ([String]?) -> ()) -> [String] {
        appStoreSearchName = []
        
        network?.getSearchResult(name) { json in
            if let json = json {
                if let results = json["results"] as? [[String:Any]] {
                    debugPrint("results = \(results) :::: name = \(name)")
                    self.appStoreSearchName = self.setAppStoreSearchName(results, name: name)
                }
            }
            
            completion(self.appStoreSearchName)
        }
        
        return []
    }
    
    func getAppList(_ name: String, completion: @escaping () -> ()) {
        appStoreList = []
        
        network?.getSearchResult(name) { json in
            
            if let json = json {
                if let results = json["results"] as? [[String:Any]] {
                    debugPrint("results = \(results)")
                    self.setAppStoreModel(results)
                }
                
                if let count = json["resultCount"] as? Int {
                    self.resultCount = count
                }
            }
            
            completion()
        }
    }
    
    func setAppStoreSearchName(_ results: [[String:Any]], name: String) -> [String] {
        var trackNames: [String] = []
        var count = results.count
        
        if count > 13 {
            count = 13
        }
        
        for idx in 0 ..< results.count {
            let result = results[idx]
            
            if let trackName = result["trackName"] as? String {
                
                trackNames.append(trackName)
            }
        }
        
        return trackNames
    }
    
    func setAppStoreModel(_ results: [[String:Any]]) {
        for idx in 0 ..< results.count {
            var model: AppStoreModel = AppStoreModel()
            let result = results[idx]
            
            model.advisories = result["advisories"] as? [String]
            model.supportedDevices = result["supportedDevices"] as? [String]
            model.isGameCenterEnabled = result["isGameCenterEnabled"] as? Bool ?? false
            
            model.screenshotUrls = result["screenshotUrls"] as? [String]
//            model.screenshotUrlDatas = getUrlImageData(model.screenshotUrls!)
            model.ipadScreenshotUrls = result["ipadScreenshotUrls"] as? [String]
            model.appletvScreenshotUrls = result["appletvScreenshotUrls"] as? [String]
            model.artworkUrl60 = result["artworkUrl60"] as? String
            model.artworkUrl512 = result["artworkUrl512"] as? String
            model.artworkUrl100 = result["artworkUrl100"] as? String
            model.artistViewUrl = result["artistViewUrl"] as? String
            
            model.features = result["features"] as? [String]
            model.kind = result["kind"] as? String
            model.currentVersionReleaseDate = result["currentVersionReleaseDate"] as? String
            model.primaryGenreName = result["primaryGenreName"] as? String
            model.sellerName = result["sellerName"] as? String
            model.isVppDeviceBasedLicensingEnabled = result["isVppDeviceBasedLicensingEnabled"] as? Bool ?? false
            model.primaryGenreId = result["primaryGenreId"] as? Int
            model.minimumOsVersion = result["minimumOsVersion"] as? String
            model.formattedPrice = result["formattedPrice"] as? String

            model.releaseNotes = result["releaseNotes"] as? String
            model.releaseDate = result["releaseDate"] as? String
            model.trackId = result["trackId"] as? Int
            model.trackName = result["trackName"] as? String
            model.genreIds = result["genreIds"] as? String
            model.trackCensoredName = result["trackCensoredName"] as? String
            model.languageCodesISO2A = result["languageCodesISO2A"] as? [String]
            
            model.fileSizeBytes = result["fileSizeBytes"] as? String
            model.sellerUrl = result["sellerUrl"] as? String
            
            model.contentAdvisoryRating = result["contentAdvisoryRating"] as? String
            model.averageUserRatingForCurrentVersion = result["averageUserRatingForCurrentVersion"] as? Double
            model.userRatingCountForCurrentVersion = result["userRatingCountForCurrentVersion"] as? Int
            model.averageUserRating = result["averageUserRating"] as? Double
            model.trackViewUrl = result["trackViewUrl"] as? String
            model.trackContentRating = result["trackContentRating"] as? String
            model.description = result["description"] as? String
            
            model.price = result["price"] as? Double
            model.genres = result["genres"] as? [String]
            model.artistId = result["artistId"] as? Int
            model.artistName = result["artistName"] as? String
            model.currency = result["currency"] as? String
            model.bundleId = result["bundleId"] as? String
            model.version = result["version"] as? String
            model.wrapperType = result["wrapperType"] as? String
            model.userRatingCount = result["userRatingCount"] as? Int
            
            appStoreList?.append(model)
        }
    }
}
