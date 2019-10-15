//
//  CreateJournalVC.swift
//  DayTwo
//
//  Created by Nazar Petruk on 08/10/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import RealmSwift

class CreateJournalVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: IBOutlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var setDateBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stackBtmView: UIStackView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewBottom: UIScrollView!
    
    //MARK: Vars
    var date = Date()
    var imagePicker = UIImagePickerController()
    var imagesArray : [UIImage] = []
    var beginWithCam = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateBtn.layer.cornerRadius = 7
        
        imagePicker.delegate = self
        
        //Notifications Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        scrollViewBottom.layer.cornerRadius = 7
        scrollViewBottom.layer.borderWidth = 1
        scrollViewBottom.layer.borderColor = #colorLiteral(red: 0, green: 0.8361462951, blue: 0.8281900883, alpha: 1)
        scrollViewBottom.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if beginWithCam {
            beginWithCam = false
            cameraBtnPressed("")
        }
    }
    
    //MARK:ScrolltoKeyboardClipFunc
    @objc func keyboardWillHide(notification:  Notification) {
        changeKeyboardHightBack(notification: notification)
    }
    @objc func keyboardWillShow(notification:  Notification) {
        changeKeyboardHight(notification: notification)
    }
    func changeKeyboardHight(notification: Notification){
        if let keyBoardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyBoardHight = keyBoardFrame.cgRectValue.height
            bottomConstraint.constant = keyBoardHight
        }
    }
    func changeKeyboardHightBack(notification: Notification){
        if let keyBoardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyBoardHight = keyBoardFrame.cgRectValue.height
            bottomConstraint.constant = keyBoardHight
        }
    }
    
    //MARK: IBActions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let realm =  try? Realm(){
            let entry = Entry()
            entry.userDayDesc = textView.text
            entry.date = date
            for image in imagesArray {
                let img = Picture(image: image)
                entry.picture.append(img)
                img.entry = entry
            }
            try? realm.write {
                realm.add(entry)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func setDateBtnPressed(_ sender: Any) {
        textView.isHidden = false
        datePicker.isHidden = true
        setDateBtn.isHidden = true
        date = datePicker.date
        updateDate()
    }
    
    @IBAction func calendarBtnPressed(_ sender: Any) {
        textView.isHidden = true
        datePicker.isHidden = false
        setDateBtn.isHidden = false
        datePicker.date = date
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Methods
    func updateDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM, yy"
        navBar.topItem?.title = formatter.string(from: date)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagesArray.append(userImg)
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 85).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
            imageView.image = userImg
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 42.5
            imageView.layer.masksToBounds = true
            
            stackBtmView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true) {
                
            }
        }
    }
}
