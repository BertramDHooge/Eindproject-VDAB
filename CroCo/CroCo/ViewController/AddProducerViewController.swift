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
    
    func addStock(_ stock: Stock) {
        
        if stockList.contains(where: { (closureStock) -> Bool in
            closureStock.portion.portionDescription == stock.portion.portionDescription
        }){
        stockList.append(stock)
        }
    }
    
    
    @IBOutlet weak var companyName: UITextField!
    
    let mainProduct = ["groenten", "fruit", "melk", "eieren", "vlees"]
    
    var pickerViewMainProduce = UIPickerView()
    var stockList: [Stock] = []
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
    
    //    solve: int for streetnumber is not logic, not for postalCode either. Maybe find dependency for places on Git?
    
    @IBAction func saveBarButonTapped(_ sender: UIBarButtonItem) {
//        guard let companyName = companyName.text, !companyName.isEmpty else {return}
//        guard let firstName = contactDotNameDotSurname.text, !firstName.isEmpty else {return}
//        guard let lastName = contactDotNameDotLastname.text, !lastName.isEmpty else {return}
//        guard let place = place.text, !place.isEmpty else {return}
//        guard let postalCode = postalCode.text, !postalCode.isEmpty else {return}
//        guard let streetName = streetName.text, !streetName.isEmpty else {return}
//        guard let streetNumber = streetNumber.text, !streetNumber.isEmpty else {return}
//        guard let telephoneNumber = telephoneNumber.text, !telephoneNumber.isEmpty else {return}
//        guard let emailAddress = emailAddress.text, !emailAddress.isEmpty else {return}
        
        let veltWinkelName = Name(firstName: "Ward", lastName: "Janssen")
        let locationVeltWinkel = CLLocation(latitude: 50.9794442, longitude: 4.7503198)
        let adresVeltWinkel = Address(streetName: "Guldentop", streetNumber: 1, postalCode: 3118, place: "Werchter")
        let veltWinkelInfo = Contact(name: veltWinkelName, address: adresVeltWinkel, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let veltWinkelCrops = [Stock(portion: Portion(portionDescription: "2 kg bintjes", sellingPriceSinglePortion: 1), amountOfStockPortionsAvailable: 30, amountOfStockSelected: 0, totalCostOfSelectedStock: 0.0)]
        
        let VeltWinkelProducer: Producer = Producer(companyName: "Veltwinkel", contact: veltWinkelInfo, location: locationVeltWinkel, locationString: "Guldentop 23, Werchter", delivery: true, mainProduce: .vegetable, deliveryHours: "zaterdag tussen 10.00 en 12.00", pickUpHours: "vrijdag tussen 18.00 en 20.00", stocks: [Stock(portion: Portion(portionDescription: "0.5 kg gekookte aardappeltjes", sellingPriceSinglePortion: 1.0), amountOfStockPortionsAvailable: 100, amountOfStockSelected: 1, totalCostOfSelectedStock: 1)])

//        let producet = Producer(companyName: companyName, contact: Contact(name: Name(firstName: firstName, lastName: lastName), address: Address(streetName: streetName, streetNumber: Int(streetNumber)!, postalCode: Int(postalCode)!, place: place), telephoneNumber: telephoneNumber, emailAddress: emailAddress), location: CLLocation(latitude: 50.748273, longitude: 4.346720), locationString: place, delivery: false, mainProduce: .fruit, deliveryHours: "", pickUpHours: "", stocks: stockList)
        
        addProducer(VeltWinkelProducer)
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
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
        let testDictionary: [String: Any] = ["CompanyName": producer.companyName,
                                             "ContactFirstName": producer.contact.name.firstName,
                                             "ContactlastName": producer.contact.name.lastName,
                                             "Place": producer.contact.address.place,
                                             "PostalCode": producer.contact.address.postalCode,
                                             "StreetName": producer.address?.streetName,
                                             "StreetNumber": producer.address?.streetNumber,
                                             "TelephoneNumber": producer.contact.telephoneNumber,
                                             "EmailAddress": producer.contact.emailAddress,
                                             "Stock": ["stock": "Stock"]]
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
