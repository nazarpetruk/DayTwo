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


