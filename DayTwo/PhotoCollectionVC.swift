//
//  PhotoCollectionVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    //MARK: Vars & Const
    var images : Results<Picture>?
    
    override func viewDidLoad() {
        getPictures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }
    
    func getPictures() {
        if let realm = try? Realm() {
            images = realm.objects(Picture.self)
            collectionView?.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = self.images {
            return images.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
            
            if let img = images?[indexPath.row]{
             cell.imageCellView.image = img.smallImg()
             cell.dayLbl.text = img.entry?.dataFormattingDay()
             cell.monthYearlbl.text = img.entry?.dataMonthAndYearString()
                
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2)
        print(size)
        return size
    }
    
}
