//
//  MainTabBarVC.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/15.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
        self.selectedIndex = 4
        
        app.tabBarHeight = self.tabBar.frame.height
    }
    
    func setTabBar() {
        self.tabBar.isTranslucent = false
        var viewControllers: [UIViewController] = [UIViewController]()
        
        // 1
        guard let todayMainVC = UIStoryboard.init(name: "TodayMainVC", bundle: nil).instantiateViewController(withIdentifier: "TodayMainVC") as? TodayMainVC else {
            return
        }
        todayMainVC.tabBarItem.image = UIImage(systemName: "tray.full.fill")
        viewControllers.append(todayMainVC)
        
        // 2
        guard let gameMainVC = UIStoryboard.init(name: "GameMainVC", bundle: nil).instantiateViewController(withIdentifier: "GameMainVC") as? GameMainVC else {
            return
        }
        gameMainVC.tabBarItem.image = UIImage(systemName: "airplane")
        viewControllers.append(gameMainVC)
        
        // 3
        guard let appMainVC = UIStoryboard.init(name: "AppMainVC", bundle: nil).instantiateViewController(withIdentifier: "AppMainVC") as? AppMainVC else {
            return
        }
        appMainVC.tabBarItem.image = UIImage(systemName: "app.gift")
        viewControllers.append(appMainVC)
        
        // 4
        guard let updateMainVC = UIStoryboard.init(name: "UpdateMainVC", bundle: nil).instantiateViewController(withIdentifier: "UpdateMainVC") as? UpdateMainVC else {
            return
        }
        updateMainVC.tabBarItem.image = UIImage(systemName: "square.and.arrow.down.fill")
        viewControllers.append(updateMainVC)

        // 5
        guard let SearchMainVC = UIStoryboard.init(name: "SearchMainVC", bundle: nil).instantiateViewController(withIdentifier: "SearchMainVC") as? SearchMainVC else {
            return
        }
        SearchMainVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let naviSearchMainVC = UINavigationController.init(rootViewController: SearchMainVC)
        naviSearchMainVC.navigationBar.topItem?.title = "검색"
        viewControllers.append(naviSearchMainVC)
        
        self.setViewControllers(viewControllers, animated: true)
    }
}
