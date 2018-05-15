//
//  addProducerViewController.swift
//  
//
//  Created by Ward Janssen on 06/05/2018.
//
//  Documentation still needed

import UIKit
import Firebase
import MapKit

class AddProducerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddStockDelegate {
    
    var dataBase: Firestore!
    
    
    @IBOutlet weak var companyName: UITextField!
    
    let mainProduct = ["groenten", "fruit", "melk", "eieren", "vlees", "gevogelte", "meerdere"]
    
    var pickerViewMainProduce = UIPickerView()
    var stockList: [Stock] = []
    var mainProduce = MainProduce.other
    
    //   MARK: -My outlets
    
    @IBOutlet weak var contactDotNameDotSurname: UITextField!
    @IBOutlet weak var contactDotNameDotLastname: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var streetNumber: UITextField!
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var mainProduceTextField: UITextField!
    @IBOutlet weak var delivery: UISwitch!

    //  MARK: -My actions
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addStock(_ stock: Stock) {
        
        print(stock.portion.sellingPriceSinglePortion)
        if !stockList.contains(where: { (closureStock) -> Bool in
            closureStock.portion.portionDescription == stock.portion.portionDescription
        }){
            print(stock.portion.portionDescription)
            stockList.append(stock)
        }
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
        
        let address = Address(streetName: streetName, streetNumber: Int(streetNumber)!, postalCode: Int(postalCode)!, place: place)
        
        
        let producer = Producer(companyName: companyName, contact: Contact(name: Name(firstName: firstName, lastName: lastName), address: address, telephoneNumber: telephoneNumber, emailAddress: emailAddress), location: nil, locationString: address.fullAddress, delivery: false, mainProduce: mainProduce, deliveryHours: "", pickUpHours: "", stocks: stockList)
        
        addProducer(producer)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        
        //      MARK: -pickerView for mainProduce
        
        pickerViewMainProduce.delegate = self
        pickerViewMainProduce.dataSource = self
        
        mainProduceTextField.inputView = pickerViewMainProduce
        mainProduceTextField.textAlignment = .center
        mainProduceTextField.placeholder = "kies je hoofdproduct"

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainProduct.count
    }
//    et mainProduct = ["groenten", "fruit", "melk", "eieren", "vlees", "gevogelte", "meerdere"]
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            mainProduce = .vegetable
        case 1:
            mainProduce = .fruit
        case 2:
            mainProduce = .dairy
        case 3:
            mainProduce = .eggs
        case 4:
            mainProduce = .meat
        case 5:
            mainProduce = .poultry
        default:
            mainProduce = .other
        }
        return mainProduct[row]
    }
    
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent: Int) {
        mainProduceTextField.text = mainProduct[row]
        mainProduceTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initiateAddStockVC" {
            
            if let destinationVC = segue.destination as? stockViewController {
                
                destinationVC.delegate = self
            }
        }
    }
//    guard let companyName = companyName.text, !companyName.isEmpty else {return}
//    guard let firstName = contactDotNameDotSurname.text, !firstName.isEmpty else {return}
//    guard let lastName = contactDotNameDotLastname.text, !lastName.isEmpty else {return}
//    guard let place = place.text, !place.isEmpty else {return}
//    guard let postalCode = postalCode.text, !postalCode.isEmpty else {return}
//    guard let streetName = streetName.text, !streetName.isEmpty else {return}
//    guard let streetNumber = streetNumber.text, !streetNumber.isEmpty else {return}
//    guard let telephoneNumber = telephoneNumber.text, !telephoneNumber.isEmpty else {return}
//    guard let emailAddress = emailAddress.text, !emailAddress.isEmpty else {return}
    private func addProducer(_ producer: Producer) {
        var reference: DocumentReference? = nil
        
        var testStock: [String: Any] = [:]
        
        
        
        for stock in producer.stocks {
            let testPortion = ["AmountOfPortions": stock.amountOfStockPortionsAvailable, "SellingPricePerPortion": stock.portion.sellingPriceSinglePortion] as Any
            
            testStock.updateValue(testPortion, forKey: stock.portion.portionDescription)
        }

        let testDictionary: [String: Any] = ["CompanyName": producer.companyName as Any,
                                             "ContactFirstName": producer.contact.name.firstName,
                                             "ContactlastName": producer.contact.name.lastName,
                                             "Place": producer.contact.address.place,
                                             "PostalCode": producer.contact.address.postalCode,
                                             "StreetName": producer.contact.address.streetName as Any,
                                             "StreetNumber": producer.contact.address.streetNumber as Any,
                                             "TelephoneNumber": producer.contact.telephoneNumber as Any,
                                             "EmailAddress": producer.contact.emailAddress as Any,
                                             "MainProduce": producer.mainProduce.rawValue,
                                             "Stock": testStock]
        reference = dataBase.collection("Producers").addDocument(data: testDictionary) {error in
            if let error = error {
                print(error)
            } else {
                print(reference!.documentID)
            }
        }
    }
    // MARK: - Navigation
    
    // stock segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addStockSegue" {
//            let stockData = segue.destination  as! stockViewController
//            stockData.onSave = {[foodtype, cropName, quantity, quantityType, stockPortionsAmount, pricePerPortion]  in
//          // breng hier de verbinding met fireStore
//        }
//    }
//
//    }
//      unwind(for: self, towardsViewController: stockViewController)
}
