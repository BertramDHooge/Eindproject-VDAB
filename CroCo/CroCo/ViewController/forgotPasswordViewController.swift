//
//  forgotPasswordViewController.swift
//  CroCo
//
//  Created by Ward Janssen on 05/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

class forgotPasswordViewController: UIViewController {

    //    MARK: my outlets
    
    @IBOutlet weak var passwordTextField: UITextField!
    
        //  MARK: my actions
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        if let email = passwordTextField.text, passwordTextField.text != "" {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                    if error != nil {
                        
                        // Error - Unidentified Email
                    
                        
                        let alertController = UIAlertController(title: "Emailadress onbekend", message: "Gelieve uw Email adres in te geven waarmee je met SLA hebt aangemeld", preferredStyle: .alert)
                        
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                    } else {
                        
                        // Success - Sends recovery email
                        
                        let alertController = UIAlertController(title: "Email verzonden", message: "Kijk naar uw inbox Email om paswoord te vernieuwen", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alertController, animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
