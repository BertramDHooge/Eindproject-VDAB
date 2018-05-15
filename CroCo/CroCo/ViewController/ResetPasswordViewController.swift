
 //  CroCo
 //
 //  Created by Ward Janssen on 05/05/2018.
 //  Copyright © 2018 VDAB. All rights reserved.
 //
 
 import UIKit
 import Firebase
 
 class ResetPasswordViewController: UIViewController {
    
    //    MARK: my outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    //  MARK: my actions
    
    /// Dismisses the current ViewController
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Resets the password connected with the inseted email address
    @IBAction func passwordResetButton(_ sender: UIButton) {
        if let email = emailTextField.text, email != "" {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if let error = error {
                    
                    let alertController = UIAlertController(title: "Emailadress onbekend", message: "Gelieve uw emailadres na te kijken", preferredStyle: .alert)
                    
                    
                    
                    let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Email verzonden", message: error?.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: {self.dismiss(animated: true, completion: nil)})
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 }
