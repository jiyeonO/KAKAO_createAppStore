//
//  SearchDetailVC.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/17.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class SearchDetailVC: UIViewController {
    
    var detailModel: AppStoreModel?
    var screenshots: [String]?
    
    @IBOutlet var artworkIV: UIImageView!
    @IBOutlet var trackNameLbl: UILabel!
    @IBOutlet var artistNameLbl: UILabel!
    
    @IBOutlet var openBtn: UIButton!
    
    @IBOutlet var averageUserRatingLbl: UILabel!
    @IBOutlet var averageStarLbl: UILabel!
    @IBOutlet var userRatingCountLbl: UILabel!
    
    @IBOutlet var genresLbl: UILabel!
    @IBOutlet var contentAdvisoryRatingLbl: UILabel!
    
    @IBOutlet var versionLbl: UILabel!
    @IBOutlet var timeLaterLbl: UILabel!
    
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var descriptionLblHeight: NSLayoutConstraint!
    @IBOutlet var fullDescriptBtn: UIButton!
    @IBOutlet var screenshotsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectNib = UINib(nibName: "DetailScreenshotsCVCell", bundle: nil)
        screenshotsCollectionView.register(collectNib, forCellWithReuseIdentifier: "DetailScreenshotsCVCell")
        
        initUI()
        setComponent()
    }
    
    //MARK: - Draw UI
    func initUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        artworkIV.layer.cornerRadius = 15
        openBtn.layer.cornerRadius = 12
        
        if let _detailModel = detailModel {
            if let artworkUrl160 = _detailModel.artworkUrl60, artworkUrl160.isEmpty == false {
                artworkIV.image = getUrlImage(artworkUrl160)
            }
            
            if let trackName = _detailModel.trackName {
                trackNameLbl.text = trackName
            }
            
            if let artistName = _detailModel.artistName {
                artistNameLbl.text = artistName
            }
            
            
            if let avgUserRating = _detailModel.averageUserRating {
                averageUserRatingLbl.text = String(format: "%.1f", avgUserRating)
                averageStarLbl.text = KKOManager.shared.getStarString(Int(avgUserRating.rounded()))
            }
            
            if let userRatingCount = _detailModel.userRatingCount {
                userRatingCountLbl.text = "\(userRatingCount)개의 평가"
            }
            
            if let genres = _detailModel.genres, genres.isEmpty == false {
                genresLbl.text = genres[0]
            }
            
            if let contentAdvisoryRating = _detailModel.contentAdvisoryRating {
                contentAdvisoryRatingLbl.text = contentAdvisoryRating
            }
            
            if let version = _detailModel.version {
                versionLbl.text = "버전 " + version
            }
            
            if let releaseDate = _detailModel.currentVersionReleaseDate {
                timeLaterLbl.text = calculatingDate(fromDate: releaseDate)
            }
            
            
            if let description = _detailModel.description{
                descriptionLbl.text = description
            }
        }
    }
    
    func setComponent() {
        if let _detailModel = detailModel, let screenshotUrls = _detailModel.screenshotUrls {
            
            screenshots = screenshotUrls
        }
    }
    
    // MARK:- Utility
    func calculatingDate(fromDate: String) -> String {
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"     // 2020-08-06T02:58:40Z
        let _fromeDate: Date = dateFormatter.date(from: fromDate) ?? today
        let delta = today.timeIntervalSince(_fromeDate)
        // let diffHour = Int(delta / (60 * 60 * 24))
        var diffHour = delta - 14400
        
        let words = ["초", "분", "시간", "일", "주", "개월", "년"]
        let calculates = [1, 60, 60, 24, 7, 4, 12]
        var idx = 0
        
        for i in 0 ..< calculates.count {
            let result = diffHour / Double(calculates[i])
            
            if result < 1 {
                if i != 0 {
                    idx = i - 1
                } else {
                    idx = i
                }
                
                break
            } else {
                diffHour = result
            }
            
            if i == (calculates.count-1) {
                idx = i
            }
        }
        
        return "\(Int(diffHour))\(words[idx]) 전"
    }
    
    // MARK:- Button Touch Event
    @IBAction func showVersionRecord(_ sender: UIButton) {
        //
    }
    
    @IBAction func showFullDescriptionContent(_ sender: UIButton) {
        fullDescriptBtn.isHidden = true
        descriptionLblHeight.priority = UILayoutPriority(rawValue: 700)
    }
}


