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
    
//    let docRef = storage.reference
    
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
    
    @IBAction func pickingHour(_ sender: UIDatePicker) {
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
        
        let dataToSave: [String: Any] = ["producent":["bedrijfsNaam":companyName, "voornaamContact": firstName, "achternaamContact": lastName, "woonplaats": place, "postcode": postalCode, "straatnaam": streetName, "huisnummer": streetNumber, "telefoonnummer": telephoneNumber, "emailadres": emailAddress]]
    }
    
//     let place = place.text, let postalCode = postalCode.text, let streetName = streetName.text, let streetNumber = streetNumber.text, let telephoneNumber = telephoneNumber.text, let emailAddress = emailAddress.text {
//            let producer = Producer(companyName: companyName, contact: Contact(name: Name(firstName: firstName, lastName: lastName), address: Address(streetName: streetName, streetNumber: streetNumber, postalCode: postalCode, place: place), telephoneNumber: telephoneNumber, emailAddress: emailAddress), companyImage: <#T##String?#>, location: <#T##CLLocation#>, delivery: delivery.isOn, mainProduce: <#T##MainProduce#>, deliveryHours: <#T##Date#>, pickUpHours: <#T##Date#>, validation: <#T##Int?#>, stocks: <#T##[Stock]#>)
//        }

    override func viewDidLoad() {
        super.viewDidLoad()

//    docRef = FireStore.firestore().collection("producer").document("Producent1")
//        docRef.setData(dataToSave) {
//            (error) in
//            if let error = error {
//                print("Oh nee een fout! \(error.localizedDescription)")
//            } else {
//                print("Data is opgeslaan")
//            }
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  MARK: -IBActions
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
