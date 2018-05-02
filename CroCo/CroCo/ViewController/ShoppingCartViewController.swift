//
//  ShoppingCartViewController.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    let arrayOfProducersCrops: [Crop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adressMammoth = Address(streetName: "Ice Lane", streetNumber: 1, postalCode: 1333, place: Place.kesselLo)
        let mammothName = Name(firstName: "Mammoth", lastName: "Wooly")
        let infoMammoth = Contact(name: mammothName, address: adressMammoth, telephoneNumber: "123456789", emailAddress: "imAMammoth")
        
        let bertramName = Name(firstName: "Bertram", lastName: "nenHooge")
        let adressBertram = Address(streetName: "ClosetoSchool", streetNumber: 1, postalCode: 1234, place: Place.leuven)
        let infoBertram = Contact(name: bertramName, address: adressBertram, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        
        let mammothCrops = Producer(companyName: "Tolis", contact: infoMammoth, companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.98, longitude: 4.78), delivery: true, mainProduce: MainProduce.vegetableFruitDairy, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crop: arrayOfProducersCrops)
        
        let bertramCrops = Producer(companyName: "VeltWinkel", contact: infoBertram, companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.98, longitude: 4.75), delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crop: arrayOfProducersCrops)


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProducersCrops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producersCrop = tableView.dequeueReusableCell(withIdentifier: "producersCrop", for: indexPath)
        let crop = arrayOfProducersCrops[indexPath.row]
        // Configure the ...
        
        return producersCrop
    }
 
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
