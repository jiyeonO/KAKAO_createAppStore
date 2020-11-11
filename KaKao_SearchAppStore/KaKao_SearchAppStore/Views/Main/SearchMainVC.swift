//
//  SearchMainVC.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class SearchMainVC: UIViewController {
    
    //MARK: - Define Obj
    var userKWDList:[String] = []
    var filtered:[String] = []
    
    var viewModel: AppStoreViewModel?
    var resultCount: Int = 0
    
    var viewType: SearchViewType = .main
    /**
     * 키보드 ON 시에 키보드 높이만큼 스크롤 올리기
     */
    var keyboardHeight: CGFloat? {
        didSet {
            if viewType == .filtered {
                self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardHeight ?? 333) - safeAreaBottomCheck() - (app.tabBarHeight ?? 56), right: 0.0)
                self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardHeight ?? 333) - safeAreaBottomCheck() - (app.tabBarHeight ?? 56), right: 0.0)
            }
        }
    }
    
    /**
     * 조회 결과가 없는 경우 대비
     */
    var isNotFound: Bool = false {
        didSet {
            if isNotFound {
                DispatchQueue.main.async {
                    KKOManager.shared.screenUnLock()
                    
                    if let defaultNotFound = Bundle.main.loadNibNamed("NotFoundView", owner: nil, options: nil)![0] as? NotFoundView {
                        defaultNotFound.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - self.searchBar.frame.height - (app.tabBarHeight ?? 56))
                        defaultNotFound.searchTextLabel.text = "'" + (self.searchBar.text ?? "") + "'"
                        defaultNotFound.tag = 1000
                        self.tableViewContainer.addSubview(defaultNotFound)
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    for view in self.tableViewContainer.subviews {
                        if view.tag == 1000 {
                            view.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchUnderLineView: UIView!
    
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var listTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var topViewHeight: NSLayoutConstraint!
    @IBOutlet var searchBarConst: NSLayoutConstraint!
    
    
//MARK: - Draw UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setComponent()
        setInitMain()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//MARK:- Init Component
    func setComponent() {
        listTableView.dataSource = self
        listTableView.delegate = self
        scrollView.delegate = self
        searchBar.delegate = self
        
        let cellNib = UINib(nibName: "UserKWDTableViewCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: "UserKWDTableViewCell")
        let nib = UINib(nibName: "SearchListTableViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "SearchListTableViewCell")
        
        viewModel = AppStoreViewModel(Network())
        userKWDList = getUserDefaultArr(key: USER_KWD_LIST) as? [String] ?? []
    }
    
    func setInitMain() {
        self.viewType = .main
        searchUnderLineView.isHidden = true
        listTableView.isScrollEnabled = false
        listTableViewHeight.constant = CGFloat(50 * (userKWDList.count + 1))
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let frameInfo = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = frameInfo.cgRectValue
        keyboardHeight = keyboardFrame.height
    }
    
//MARK:- Utility
    func showCancelBtn(_ isShow: Bool) {
        if isShow {
            topViewHeight.constant = 0
            searchBar.setValue("취소", forKey: "cancelButtonText")
            searchBar.showsCancelButton = true
            searchUnderLineView.isHidden = false
        }
        else {
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
        }
    }
    
    func showTopView(_ isShow: Bool) {
        if isShow {
            topViewHeight.constant = 70
            searchUnderLineView.isHidden = true
        }
        else {
            topViewHeight.constant = 0
            searchUnderLineView.isHidden = false
        }
    }
    
    /**
     * 최근 검색어 저장
     */
    func saveUserKWD(_ keyword: String) {
        userKWDList = getUserDefaultArr(key: USER_KWD_LIST) as? [String] ?? []

        // 기존에 존재하는 검색어 진입 시 이전 검색어 삭제, 마지막에 추가
        for (idx, item) in userKWDList.enumerated() {
            if item == keyword {
                userKWDList.remove(at: idx)
            }
        }
        // 최근 검색어 20개 제한
        if userKWDList.count > 19 {
            userKWDList.remove(at: 0)
        }
        userKWDList.append(keyword)

        setUserDefaultArr(key: USER_KWD_LIST, value: userKWDList) // 최근 검색어 저장
    }
}

extension SearchMainVC: openButtonTouchDelegate {
    /**
     * 검색리스트에서 셀 혹은 열기 버튼 클릭 시, 상세 화면으로 이동
     */
    func openButtonTouchUpInside(_ index: IndexPath) {
        
        if let searchDetailVC = UIStoryboard.init(name: "SearchDetailVC", bundle: nil).instantiateViewController(withIdentifier: "SearchDetailVC") as? SearchDetailVC {
            
            if let models = self.viewModel?.appStoreList {
                let model = models[index.row]
                searchDetailVC.detailModel = model
            }
            self.navigationController?.pushViewController(searchDetailVC, animated: true)
        }
    }
}

extension SearchMainVC: UIScrollViewDelegate {
    /**
     * 스크롤 내려도 검색바 상단에 고정
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let searchBarY = topView.frame.size.height
        let scrollViewY = scrollView.bounds.origin.y
        
        var const = scrollViewY - searchBarY

        if const < 0 {
            const = 0
        }
        searchBarConst.constant = const
    }
}
