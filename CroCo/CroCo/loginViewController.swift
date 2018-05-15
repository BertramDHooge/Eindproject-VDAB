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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
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
    
    /// Goes back to the previous ViewController
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutActionButton(_ sender: UIButton) {
        handleSignOutButtonTapped()
        updateUI()
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Logs in the user if the textFields have been correctly filled out
    
    @IBAction func login(_ sender: UIButton) {
        
        // Checking if email and password is filled out
        
        guard let emailAddress = emailAddressTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "Login fout", message: "Beide velden moet u invullen", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: {self.dismiss(animated: true, completion: nil)})
                return
        }
        
        // error while controlling email and password
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            if let error = error  {
                let alertController = UIAlertController(title: "Login fout", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: {self.dismiss(animated: true, completion: nil)})
                return
            } else {
                let alertController = UIAlertController(title: "U bent nu ingelogd", message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: {self.dismiss(animated: true, completion: {self.performSegue(withIdentifier: "back Home from Log In Segue", sender: self)   })})
            }
            self.view.endEditing(true)
            self.updateUI()
        }
        
        //       my functions
        
    }
    @objc func handleSignOutButtonTapped() {
        do {
            try Auth.auth().signOut()
            
        } catch let err {
            print(err)
        }
    }
    
    func updateUI() {
        if let userEmail = Auth.auth().currentUser?.email {
            emailAddressTextField.text = userEmail
            passwordTextField.isHidden = true
            logoutButton.isHidden = false
            loginButton.isHidden = true
            loginButton.isEnabled = false
            signUpButton.isHidden = true
            forgotPassword.isHidden = true
        }
        else {
            emailAddressTextField.text = ""
            passwordTextField.isHidden = false
            logoutButton.isHidden = true
            loginButton.isHidden = false
            signUpButton.isHidden = false
            forgotPassword.isHidden = false
        }
    }
    
 }
