//
//  Model.swift
//  DayTwo
//
//  Created by Nazar Petruk on 10/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift
import Toucan

class Entry : Object {
    @objc dynamic var userDayDesc = ""
    @objc dynamic var date = Date()
    let picture = List<Picture>()
    
    
    func dataFormattingMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
    func dataFormattingDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    func dataFormattingYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    func dataMonthAndYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        return formatter.string(from: date)
    }
    
}

class Picture : Object {
    @objc dynamic var fullSizeImg = ""
    @objc dynamic var sImg = ""
    @objc dynamic var entry : Entry?
    
    //Saving fullSize and S size img
    convenience init(image : UIImage) {
        self.init()
        fullSizeImg = imageToUrlString(image: image)
        if let smallImg = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
            sImg = imageToUrlString(image: smallImg)
        }
    }
    
    func fullImg() -> UIImage{
        return imageByFileName(fileName: fullSizeImg)
    }
    
    func smallImg() -> UIImage{
        return imageByFileName(fileName: sImg)
    }
    
    func imageByFileName(fileName: String) -> UIImage {
         var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        path.appendPathComponent(fileName)
        if let imageData = try? Data(contentsOf: path) {
            if let image = UIImage(data: imageData){
                return image
            }
        }
        return UIImage()
    }
    
    //Image saving path
    func imageToUrlString(image: UIImage) -> String {
        if let imgData = image.pngData(){
            let fileName = UUID().uuidString + "png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendPathComponent(fileName)
            try? imgData.write(to: path)
            return fileName
        }
        return ""
    }
}


