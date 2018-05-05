//
//  CreateViewController.swift
//  CroCo
//
//  Created by Ward on 27/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - IBActions

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createAccount(_ sender: UIButton) {
        // Checking the input
        guard let username = usernameTextField.text, username != "",
            let emailAddress = emailAddressTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: "Insufficient information", message: "You must fill out all the fields to complete the registration successfully.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)

                return
        }

        // Register the user account on Firebase
        Auth.auth().createUser(withEmail: emailAddress, password: password) { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Registration error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)

                return
            }

            // Save the name of the user
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                })
            }

            // Send Verification email
            user?.sendEmailVerification(completion: nil)


            let alertController = UIAlertController(title: "Email Verification", message: "We've just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete registration.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                // Dismiss the current view controller
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        // Dismiss the keyboard
        self.view.endEditing(true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
