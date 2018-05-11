//
//  addProducerViewController.swift
//  
//
//  Created by Ward Janssen on 06/05/2018.
//
//  Documentation still needed

import UIKit
import Firebase

class AddProducerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddStockDelegate {
    
    func addStock(_ stock: Stock) {
        
        if stockList.contains(where: { (closureStock) -> Bool in
            closureStock.portion.stockName == stock.portion.stockName
        }){
        stockList.append(stock)
        }
    }
    
    
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var mainProduce: UITextField!
    
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
    @IBOutlet weak var delivery: UISwitch!

    //  MARK: -My actions
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      MARK: -pickerView for mainProduce
        
        pickerViewMainProduce.delegate = self
        pickerViewMainProduce.dataSource = self
        
        mainProduce.inputView = pickerViewMainProduce
        mainProduce.textAlignment = .center
        mainProduce.placeholder = "kies je hoofdproduct"
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
        mainProduce.text = mainProduct[row]
        mainProduce.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initiateAddStockVC" {
            
            if let destinationVC = segue.destination as? stockViewController {
                
                destinationVC.delegate = self
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
