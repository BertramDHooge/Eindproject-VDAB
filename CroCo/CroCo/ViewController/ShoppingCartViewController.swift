//
//  ShoppingCartViewController.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShoppingCartDelegate {
    
    func updatingStock(amountOfMoney amountOfmoney: Double) {
//        shoppingCart.producer.totalCropsCost = portions * stock.sellingPrice
        shoppingCart.TotalCost += shoppingCart.producer.totalCropsCost
        totalCostLabel.text = String(shoppingCart.TotalCost)
    }
    

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    
    //    var arrayOfProducers: [Producer] = []
    
    var shoppingCart: ShoppingCart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        shoppingCart.TotalCost = totalSingleCropCost
//        totalCostLabel.text = String(shoppingCart.TotalCost)


        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.producer.stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producersStockItemCell = tableView.dequeueReusableCell(withIdentifier: "producersCrop", for: indexPath) as? CropTableViewCell
//        producersStockItemCell?.shoppingCart
        let stock = shoppingCart.producer.stocks[indexPath.row]
        producersStockItemCell!.stock = stock

        // Configure the ...

        return producersStockItemCell!
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
