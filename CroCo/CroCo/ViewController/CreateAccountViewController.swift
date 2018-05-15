//
//  forgotPasswordViewController.swift
//  CroCo
//
//  Created by Ward Janssen on 05/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    //    MARK: my outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    //  MARK: my actions
    
    /// Dismisses the current ViewController
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "back to login", sender: UIBarButtonItem.self)
    }
    
    /// Resets the password connected with the inseted email address
    @IBAction func passwordResetButton(_ sender: UIButton) {
        if let email = emailTextField.text, email != "" {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Email verzonden", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: {self.dismiss(animated: true, completion: {self.performSegue(withIdentifier: "back Home from Log In Segue", sender: self)   })})
                    
                } else {
                    let alertController = UIAlertController(title: "Emailadress onbekend", message: "Gelieve uw Email adres in te geven waarmee je met SLA hebt aangemeld", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = Auth.auth().currentUser?.email
        {  emailTextField.text = email }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
