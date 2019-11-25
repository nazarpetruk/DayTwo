//
//  JournalTableVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class JournalTableVC: UITableViewController, SwipeTableViewCellDelegate{
  
    //MARK: IBOutlets
    @IBOutlet weak var whiteCameraBtn: UIButton!
    @IBOutlet weak var whitePlusBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    
    //MARK: Vars & Const
    var entries : Results<Entry>?
    var images : Results<Picture>?

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.tableVC = self
        whitePlusBtn.imageView?.contentMode = .scaleAspectFit
        whiteCameraBtn.imageView?.contentMode = .scaleAspectFit
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.isTranslucent = false
         navigationController?.navigationBar.barTintColor = UIColor(red: 0.000, green: 0.836, blue: 0.828, alpha: 1.00)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        headerView.backgroundColor = UIColor(red: 0.000, green: 0.836, blue: 0.828, alpha: 1.00)
        getDataFromRealm()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromRealm()
        tableView.reloadData()
    }
    
    //MARK: IBActions
    @IBAction func cameraBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "createNew", sender: "camera")
    }
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "createNew", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNew" {
                   if let text = sender as? String {
                       if text == "camera" {
                           let createVC = segue.destination as? CreateJournalVC
                           createVC?.beginWithCam = true
                }
            }
        }else if segue.identifier == "toDetail" {
            if let entry = sender as? Entry {
                if let detailVC = segue.destination as? JournalDetailVC {
                    detailVC.entry = entry
                }
            }
        }
    }
    //MARK: Functions
    
    func getDataFromRealm() {
        if let realm = try? Realm() {
           entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    func gradColor(bound : CGRect) -> CAGradientLayer{
//        let gradient = CAGradientLayer()
//        let startColor = UIColor(cgColor: CGColor(srgbRed: 2, green: 170, blue: 176, alpha: 1))
//        let endColor = UIColor(cgColor: CGColor(srgbRed: 0, green: 205, blue: 172, alpha: 1))
//        gradient.colors = [startColor.cgColor, endColor.cgColor]
//        gradient.frame = bound
//
//        return gradient
//    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = self.entries else { return 1 }
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? JournalTableVCCell {
            cell.delegate = self
            if let entry = entries?[indexPath.row] {
                cell.userTextLbl.text = entry.userDayDesc
                if let image = entry.picture.first?.smallImg(){
                    cell.constraintToResizeImg.constant = 130
                    cell.cellImgView.image = image
                }else{
                    cell.constraintToResizeImg.constant = 0
                }
                
                cell.monthLbl.text = entry.dataFormattingMonth()
                cell.dayLbl.text = entry.dataFormattingDay()
                cell.yearLbl.text = entry.dataFormattingYear()
                
                cell.cellElementsConfig()
            }
            return cell.cellConfig(cell: cell)
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let entry = entries?[indexPath.row]{
             performSegue(withIdentifier: "toDetail", sender: entry)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
         guard orientation == .right else { return nil }
        let deleteSwipe = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deletePicture(indexPath: indexPath.row)
            self.deleteEntries(indexPath: indexPath.row)
            do {
                
                action.fulfill(with: .delete)
                tableView.reloadData()
            }
        }
        deleteSwipe.fulfill(with: .delete)
        deleteSwipe.backgroundColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        deleteSwipe.image = UIImage(named: "delete64")
        return [deleteSwipe]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        options.expansionStyle = .destructiveAfterFill
        options.backgroundColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        return options
    }
    
    func deleteEntries(indexPath: Int){
        if let item = self.entries?[indexPath]{
                   do{
                       try self.entries?.realm!.write{
                           self.entries?.realm!.delete(item)
                       }
                   }catch{
                      print("Error while deleting item, \(error)")
                   }
               }
    }
    
    func deletePicture(indexPath: Int) {
        if let item = self.images?[indexPath]{
            do{
                try self.images?.realm!.write{
                    self.images?.realm!.delete(item)
                }
            }catch{
               print("Error while deleting item, \(error)")
            }
        }
    }
    
}
