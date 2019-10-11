//
//  JournalTableVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift

class JournalTableVC: UITableViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var whiteCameraBtn: UIButton!
    @IBOutlet weak var whitePlusBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    //MARK: Vars & Const
    var entries : Results<Entry>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        whitePlusBtn.imageView?.contentMode = .scaleAspectFit
        whiteCameraBtn.imageView?.contentMode = .scaleAspectFit
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.isTranslucent = false
         navigationController?.navigationBar.barTintColor = UIColor(red: 0.000, green: 0.836, blue: 0.828, alpha: 1.00)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        headerView.backgroundColor = UIColor(red: 0.000, green: 0.836, blue: 0.828, alpha: 1.00)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromRealm()
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
        }
    }
    //MARK: Functions
    
    func getDataFromRealm() {
        if let realm = try? Realm() {
           entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = self.entries else { return 1 }
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? JournalTableVCCell {
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
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    func gradColor(bound : CGRect) -> CAGradientLayer{
//        let startColor = UIColor(cgColor: CGColor(srgbRed: 2, green: 170, blue: 176, alpha: 1))
//        let endColor = UIColor(cgColor: CGColor(srgbRed: 0, green: 205, blue: 172, alpha: 1))
//        gradient.colors = [startColor.cgColor, endColor.cgColor]
//        gradient.frame = bound
//
//        return gradient
//    }
    
}
