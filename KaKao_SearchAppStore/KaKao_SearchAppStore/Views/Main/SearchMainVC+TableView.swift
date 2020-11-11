//
//  SearchMainVC+TableView.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/18.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

extension SearchMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewType == .searchList { // 검색 리스트에서 셀 클릭 시, 상세 화면으로 이동 (열기 버튼과 동일)
            openButtonTouchUpInside(indexPath)
            return
        }

        viewType = .searchList
        showTopView(false) // 메인에서 최근 검색어 통해 바로 접근할 때를 대비하여 셋팅
        
        KKOManager.shared.screenLock()
        self.searchBar.resignFirstResponder()
        
        // 메인에서 바로 접근할 시에 filtered 값은 셋팅이 안되어있으므로 선택한 단어로 검색
        var searchText = ""
        if let cell = tableView.cellForRow(at: indexPath) as? UserKWDTableViewCell {
            searchText = cell.searchWordLabel.text ?? ""
        }
        searchBar.text = searchText
        saveUserKWD(searchText) // 검색어 저장
        
        viewModel?.getAppList(searchText) {
            
            if self.viewModel?.resultCount ?? 0 < 1 {
                self.isNotFound = true
                return
            }
            
            DispatchQueue.main.async {
                self.listTableViewHeight.constant = CGFloat(280 * (self.viewModel?.resultCount ?? 0))
                self.listTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewType == .main {
            return userKWDList.count + 1
        }
        else if viewType == .filtered {
            return filtered.count
        }
        else if viewType == .searchList {
            return viewModel?.resultCount ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewType == .searchList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell") as! SearchListTableViewCell
            
            if let models = self.viewModel?.appStoreList {
                let model = models[indexPath.row]
                
                if let artworkUrl160 = model.artworkUrl60, artworkUrl160.isEmpty == false {
                    cell.artworkIV.image = getUrlImage(artworkUrl160)
                }
                
                if let trackName = model.trackName {
                    cell.trackNameLbl.text = trackName
                }
                
                if let genres = model.genres, genres.isEmpty == false {
                    cell.genresLbl.text = genres[0]
                }
                
                if let avgUserRating = model.averageUserRating {
                    cell.avgUserRatingLbl.text = KKOManager.shared.getStarString(Int(avgUserRating.rounded()))
                }
                
                if let userRatingCount = model.userRatingCount {
                    cell.userRatingCountLbl.text = "\(userRatingCount)"
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                if (indexPath.row == models.count - 1) {
                    KKOManager.shared.screenUnLock()
                }
                
                DispatchQueue.main.async {
                    if let screenshotUrls = model.screenshotUrls {
                        for idx in 0 ..< screenshotUrls.count {
                            if idx > 2 { break }
                            cell.screenshotIVs[idx].imageFromURL(screenshotUrls[idx] , placeholder: nil) {
                                
                            }
                        }
                    }
                }
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserKWDTableViewCell") as! UserKWDTableViewCell
            
            if viewType == .main {
                if indexPath.row == 0 {
                    cell.searchWordLabel?.text = "최근 검색어"
                    cell.searchWordLabel?.textColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
                    cell.searchWordLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
                    cell.isUserInteractionEnabled = false
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                }
                else {
                    cell.searchWordLabel?.text = userKWDList[indexPath.row-1]
                    cell.searchWordLabel?.textColor = #colorLiteral(red: 0, green: 0.5114216137, blue: 1, alpha: 1)
                    cell.searchWordLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
                }
                
                cell.imgView?.isHidden = true
                cell.imgViewWidth.constant = 10
                
                return cell
            }
            else if viewType == .filtered {
                cell.searchWordLabel?.text = filtered[indexPath.row]
                cell.searchWordLabel?.textColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
                cell.imgView?.isHidden = false
                cell.imgViewWidth.constant = 25
                cell.isUserInteractionEnabled = true
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewType == .searchList {
            return 280
        }
        return 50
    }
}
