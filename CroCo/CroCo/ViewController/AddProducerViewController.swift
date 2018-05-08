//
//  addProducerViewController.swift
//  
//
//  Created by Ward Janssen on 06/05/2018.
//

import UIKit

protocol AddProducerViewControllerDelegate {
    func add(_ producer: Producer)
}

class AddProducerViewController: UIViewController {
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var contactDotNameDotSurname: UITextField!
    @IBOutlet weak var contactDotNameDotLastname: UITextField!
//    Maak hier eventueel een pickerView vanuit een bestaand famework met al de gemeentes
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var streetNumber: UITextField!
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var delivery: UISwitch!
    // Hier nog pickerView voor afhalingen en upload foto
    @IBAction func deliveryHour(_ sender: UIDatePicker) {
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
