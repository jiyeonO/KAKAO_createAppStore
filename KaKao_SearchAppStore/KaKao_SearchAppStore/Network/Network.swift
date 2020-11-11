//
//  Network.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import Foundation

class Network {
    let defaultSession: URLSession?
    var dataTask: URLSessionDataTask?
    var models: [AppStoreModel]?
    var resultCount: Int = 0
    
    init() {
        defaultSession = URLSession(configuration: .default)
    }
    
    func getSearchName(_ searchTerm: String, completion: @escaping ([String]) -> ()) {
        
        
        
    }
    
//    func getSearchResult(_ searchTerm: String, completion: @escaping ([AppStoreModel]?, Int) -> ()) {
    func getSearchResult(_ searchTerm: String, completion: @escaping ([String: Any]?) -> ()) {
        dataTask?.cancel()
        //https://www.apple.com/kr/itunes/
        //https://itunes.apple.com/search
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "country=kr&entity=software&term=\(searchTerm)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession?.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    debugPrint("error = \(error.localizedDescription)")
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                    debugPrint("data = \(String(data: data, encoding: .utf8))")
                    let parsingData = self.jsonParsing(data)
                    completion(parsingData)
                }
            }
            
            dataTask?.resume()
        } else {
            debugPrint("NOT URL")
        }
    }
    
    func jsonParsing(_ data: Data) -> [String:Any]? {
        do {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                return json
                
//                if let results = json["results"] as? [[String:Any]] {
//                    debugPrint("results = \(results)")
//                    setAppStoreModel(results)
//                }
//
//                if let count = json["resultCount"] as? Int {
//                    resultCount = count
//                }
            }
        } catch {
            debugPrint("jsonParsing Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func getUrlImageData(_ urlString: [String]) -> [Data]? {
        do {
            
            var datas: [Data] = []
            
            for idx in 0 ..< urlString.count {
                if let url = URL(string: urlString[idx]) {
                    let data = try Data(contentsOf: url)
                    datas.append(data)
                }
            }
            
            return datas
        } catch {
            debugPrint("getUrlImageData: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func setAppStoreModel(_ results: [[String:Any]]) {
        models = []
        
        for idx in 0 ..< results.count {
            var model: AppStoreModel = AppStoreModel()
            let result = results[idx]
            
            model.advisories = result["advisories"] as? [String]
            model.supportedDevices = result["supportedDevices"] as? [String]
            model.isGameCenterEnabled = result["isGameCenterEnabled"] as? Bool ?? false
            
            model.screenshotUrls = result["screenshotUrls"] as? [String]
            model.screenshotUrlDatas = getUrlImageData(model.screenshotUrls!)
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
            
            models?.append(model)
        }
    }
}
