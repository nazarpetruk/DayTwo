//
//  CreateJournalVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit

class CreateJournalVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var setDateBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stackBtmView: UIStackView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateBtn.layer.cornerRadius = 7
    }
    
    //MARK: IBActions
    @IBAction func backBtnPressed(_ sender: Any) {
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
    }
    
    @IBAction func setDateBtnPressed(_ sender: Any) {
    }
    
    @IBAction func calendarBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
    }
}
