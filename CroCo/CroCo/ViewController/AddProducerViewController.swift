//
//  addProducerViewController.swift
//  
//
//  Created by Ward Janssen on 06/05/2018.
//
//  Documentation still needed

import UIKit
import Firebase

class AddProducerViewController: UIViewController {

    
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var contactDotNameDotSurname: UITextField!
    @IBOutlet weak var contactDotNameDotLastname: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var streetNumber: UITextField!
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var delivery: UISwitch!

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    solve: int for streetnumber is not logic, not for postalCode either. Maybe find dependency for places on Git?
    
    @IBAction func saveBarButonTapped(_ sender: UIBarButtonItem) {
        guard let companyName = companyName.text, !companyName.isEmpty else {return}
        guard let firstName = contactDotNameDotSurname.text, !firstName.isEmpty else {return}
        guard let lastName = contactDotNameDotLastname.text, !lastName.isEmpty else {return}
        guard let place = place.text, !place.isEmpty else {return}
        guard let postalCode = postalCode.text, !postalCode.isEmpty else {return}
        guard let streetName = streetName.text, !streetName.isEmpty else {return}
        guard let streetNumber = streetNumber.text, !streetNumber.isEmpty else {return}
        guard let telephoneNumber = telephoneNumber.text, !telephoneNumber.isEmpty else {return}
        guard let emailAddress = emailAddress.text, !emailAddress.isEmpty else {return}

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        listen for keyboard events - problem solved by putting content in scroll view
    
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//
//
//
//
//    }

//        stop listing for keyboard hide/show events
//
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//    }
//
//
//    @objc func keyboardWillChange(notification: Notification) {
//
//        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//        if notification.name == Notification.Name.UIKeyboardWillShow ||
//            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
//
//            view.frame.origin.y = -keyboardRect.height
//        } else {
//            view.frame.origin.y = 0
//        }
//
//    }
//
//    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
//        let moveDuration = 0.3
//        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
//
//        UIView.beginAnimations("animateTextField", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(moveDuration)
//        self.view.frame = CGRect.offsetBy(CGRect()
//    }
//
////      Keyboard shows
//    func textFieldDidBeginEditing(textField: UITextField) {
//        moveTextField(textField, moveDistance: -250, up: true)
//    }
////      Keyboard hidden
//    func textFieldDidBeginEditing(textField: UITextField) {
//        moveTextField(textField, moveDistance: -250, up: false)
//    }
//    func textFieldShouldReturn(rextField: UITextField) -> Bool {
//        UITextField.resignFirstResponder()
//        return true
    }
    

}
