//
//  SearchMainVC+SearchBar.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/18.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

extension SearchMainVC: UISearchBarDelegate {
    
    /**
     * 취소버튼 클릭 시, 검색 메인으로 돌아가기
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        showCancelBtn(false)
        
        if isNotFound {
            isNotFound = !isNotFound
        }
        
        self.viewType = .main
        showTopView(true)
        listTableView.isScrollEnabled = false
        listTableViewHeight.constant = CGFloat(50 * (userKWDList.count + 1))
        listTableView.reloadData()
    }

    /**
     * 키보드 ON
     * 단어 입력 시, filtered로 인지 > 검색 리스트 조회
     * 단어 입력 없이 클릭만 했을 시, 검색바 위치만 상단 고정 (topViewHeight 0)
    */
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        if let txt = searchBar.text, txt.count > 0 {
            self.viewType = .filtered
            self.searchBar(searchBar, textDidChange: txt)
        } else {
            self.viewType = .main
            listTableViewHeight.constant = CGFloat(50 * (userKWDList.count + 1))
        }
        
        if isNotFound {
            isNotFound = !isNotFound
        }
        
        showCancelBtn(true)
        listTableView.isScrollEnabled = true
        listTableView.reloadData()
        
        return true
    }

    /**
     * 키보드 OFF
     * 검색 완료 후 키보드 내릴때는 검색바 상단 고정 유지
     * 메인으로 돌아가기 위해서 키보드 내릴 때는 검색바 위치 및 취소버튼 리셋
     */
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0.0)
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0.0)
        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)

        if viewType == .main {
            searchBar.showsCancelButton = false
            showTopView(true)
        } else {
            showTopView(false)
        }
        
        return true
    }

    /**
     * 글자 입력
     * 글자 입력 시, 사용자 별 최근 검색어 + 앱스토어 검색 리스트 셋업
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.viewType = .main
            listTableView.isScrollEnabled = false
            listTableViewHeight.constant = CGFloat(50 * (userKWDList.count + 1))
            listTableView.reloadData()
        }
        else {
            if viewType != .filtered {
                self.viewType = .filtered
                listTableView.isScrollEnabled = true
            }
            
            filtered = userKWDList.filter({ (text) -> Bool in
                let range = (text as NSString).range(of: searchText, options: .caseInsensitive)
                return range.location != NSNotFound
            })
            
            let _ = viewModel?.getSearchAppName(searchText) { names in
                
                if let _names = names {
                    self.filtered = self.filtered + _names
                }
                
                DispatchQueue.main.async{
                    self.listTableViewHeight.constant = CGFloat(50 * (self.filtered.count))
                    self.listTableView.reloadData()
                }
            }
        }
    }

    /**
     * 검색완료 버튼 눌렀을 시
     * 조회
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            return
        }
        
        viewType = .searchList
        KKOManager.shared.screenLock()
        
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        
        saveUserKWD(searchBar.text ?? "") // 검색어 저장
        
        viewModel?.getAppList(searchBar.text ?? "") {
            
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
}
