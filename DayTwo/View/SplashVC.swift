//
//  SplashVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 25/11/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import Spring

class SplashVC: UIViewController {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline:.now() + 4.5, execute: {
           self.performSegue(withIdentifier:"segueToMain",sender: self)
        })
    }
}
