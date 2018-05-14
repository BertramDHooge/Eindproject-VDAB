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

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    
    //    var arrayOfProducers: [Producer] = []
    
    var producer: Producer!
    
    var shoppingCart: ShoppingCart! {
        didSet {
            totalCostLabel.text = String(shoppingCart.TotalCost)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        shoppingCart.TotalCost = totalSingleCropCost
//        totalCostLabel.text = String(shoppingCart.TotalCost)


        shoppingCart = ShoppingCart(producer: producer!, TotalCost: 0)
        // Do any additional setup after loading the view.
    }
    
    /// Dismisses the current ViewController
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /// Changes the total cost of the items in the shoppingcart by the entered amount
    ///
    /// - Parameter amountOfMoney: The amount the total needs to be changed by
    func changeTotalAmount(by amountOfMoney: Double) {
        shoppingCart.TotalCost += amountOfMoney
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.producer.stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producersStockItemCell = tableView.dequeueReusableCell(withIdentifier: "producersCrop", for: indexPath) as? CropTableViewCell
//        producersStockItemCell?.shoppingCart
        let stock = shoppingCart.producer.stocks[indexPath.row]
        producersStockItemCell!.stock = stock
        
        producersStockItemCell?.shoppingCartDelegate = self

        // Configure the ...

        return producersStockItemCell!
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "initiateInfoVC", sender: producer)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "initiateInfoVC"{
            if let destinationVC = segue.destination as? ProducerInformationViewController{
                if let producer = sender as? Producer{
                    destinationVC.producer = producer
                }
            }
        }
    }
 

}
