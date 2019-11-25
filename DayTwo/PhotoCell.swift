//
//  PhotoCell.swift
//  DayTwo
//
//  Created by Nazar Petruk on 11/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var monthYearlbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    
    func cellConfig() {
        
        imageCellView.layer.cornerRadius = 10
        imageCellView.layer.masksToBounds = true
        imageCellView.layer.borderWidth = 3
        imageCellView.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
    }
}
