//
//  JournalTableVCCell.swift
//  DayTwo
//
//  Created by Nazar Petruk on 10/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import SwipeCellKit

class JournalTableVCCell: SwipeTableViewCell {

    @IBOutlet weak var constraintToResizeImg: NSLayoutConstraint!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var userTextLbl: UILabel!
    @IBOutlet weak var cellImgView: UIImageView!
    @IBOutlet weak var stackViewCell: UIStackView!
    @IBOutlet weak var viewForStackConfig: UIView!
    
    func cellElementsConfig() {
        
        cellImgView.layer.cornerRadius = 60
        cellImgView.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        cellImgView.layer.borderWidth = 1
        cellImgView.layer.masksToBounds = true
        viewForStackConfig.layer.cornerRadius = 10
        viewForStackConfig.layer.masksToBounds = true
    }
    
    func cellConfig(cell: UITableViewCell) -> UITableViewCell{
        
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        
        return cell
    }
    
}
