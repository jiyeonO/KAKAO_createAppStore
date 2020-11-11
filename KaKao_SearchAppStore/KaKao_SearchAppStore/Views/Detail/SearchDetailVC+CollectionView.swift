//
//  SearchDetailVC+CollectionView.swift
//  KaKao_SearchAppStore
//
//  Created by 오지 on 2020/08/18.
//  Copyright © 2020 오지. All rights reserved.
//

import UIKit

extension SearchDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailScreenshotsCVCell", for: indexPath) as! DetailScreenshotsCVCell
        
        if let _screenshots = screenshots {
            cell.screenshotIVs.imageFromURL(_screenshots[indexPath.row], placeholder: nil) {
                
            }
        }
        return cell
    }
}

//MARK: Collection View Delegate FlowLayout
extension SearchDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 320)
    }
}
