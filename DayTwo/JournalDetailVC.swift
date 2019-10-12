//
//  JournalDetailVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift

class JournalDetailVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var userDayDescLbl: UILabel!
    @IBOutlet weak var detailStackView: UIStackView!
    
    
    //MARK: Vars & Const
    var entry : Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDayDescLbl.layer.cornerRadius = 10
        userDayDescLbl.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        userDayDescLbl.layer.borderWidth = 3
        userDayDescLbl.layer.masksToBounds = true
        
        if let entry = self.entry {
            title = entry.dataFormattingDay() + " " + entry.dataFormattingMonth() + " " + entry.dataFormattingYear()
            userDayDescLbl.text = entry.userDayDesc
            for img in entry.picture{
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                let ratio = img.fullImg().size.height / img.fullImg().size.width
                imageView.image = img.fullImg()
                
                detailStackView.addArrangedSubview(imageView)
                imageView.widthAnchor.constraint(equalTo: detailStackView.widthAnchor, multiplier: 1.0).isActive = true
                imageView.heightAnchor.constraint(equalTo: detailStackView.widthAnchor, multiplier: ratio).isActive = true
                imageView.layer.cornerRadius = 10
                imageView.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
                imageView.layer.borderWidth = 4
                imageView.layer.masksToBounds = true
            }
        }else{
            userDayDescLbl.text = ""
        }
    }
}
