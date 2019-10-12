//
//  SplitVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 11/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit

class SplitVC: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible

    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
