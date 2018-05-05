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
    
    @IBOutlet weak var passwordTextFielkd: UITextField!
    
        //  MARK: my actions
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: "email@email") { error in
            // Your code here
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
