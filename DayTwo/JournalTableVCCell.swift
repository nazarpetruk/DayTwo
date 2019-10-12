//
//  JournalTableVCCell.swift
//  DayTwo
//
//  Created by Nazar Petruk on 10/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit

class JournalTableVCCell: UITableViewCell {

    @IBOutlet weak var constraintToResizeImg: NSLayoutConstraint!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var userTextLbl: UILabel!
    @IBOutlet weak var cellImgView: UIImageView!
    @IBOutlet weak var stackViewCell: UIStackView!
}
