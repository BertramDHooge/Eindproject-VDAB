//
//  stockViewController.swift
//  CroCo
//
//  Created by Ward Janssen on 10/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class stockViewController: UIViewController {

    var onSave: (([_ foodtype: String,_ cropName: String,_ quantity: Int,_ quantityType: String,_ stockPortionsAmount: Int,_ pricePerPortion: Double])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
 
}
