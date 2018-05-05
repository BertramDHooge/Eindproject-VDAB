//
//  loginViewController.swift
//  CroCo
//
//  Created by Ward on 27/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailAddressTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        // Checking the input
        guard let emailAddress = emailAddressTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "Login fout", message: "Beide invulvelden moet u invullen", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        // Login at Firebase
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            // Verify email address
            guard let currentUser = user, currentUser.isEmailVerified else {
                let alertController = UIAlertController(title: "Email niet bevestigd", message: "We stuurden u een bevestigingslink. Indien je opnieuw een link wil ontvangen klik op", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Resend email", style: .default, handler: { (action) in
                    user?.sendEmailVerification(completion: nil)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            // Dismiss keyboard
            self.view.endEditing(true)
            
            // Perform segue
        }
        let alertController = UIAlertController(title: "Bedankt voor uw bestelling", message: "Uw bestelling kan worden afgehaald of gebracht op het afgesproken tijdstip", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ -> Void in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
            self.present(nextViewController, animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    
    }

    
}
