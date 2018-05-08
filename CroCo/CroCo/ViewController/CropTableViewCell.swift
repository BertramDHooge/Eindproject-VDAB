
//
//  CropTableViewCell.swift
//  CroCo
//
//  Created by Louis Loeckx on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase
protocol ShoppingCartDelegate {
    func updatingStock(amountOfMoney: Double)
}
class CropTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCropPortionsAvailableLabel: UILabel!
    @IBOutlet weak var cropNameLabel: UILabel!
    
    @IBOutlet weak var pricingAndWeightPerPortionLabel: UILabel!
    @IBOutlet weak var totalNumberOfPortionsSelectedLabel: UILabel!
    
    @IBOutlet weak var addPortionButton: UIButton!
    @IBOutlet weak var removePortionButton: UIButton!
    @IBOutlet weak var numberOfPortions: UILabel!
    
    var stock: Stock? { didSet { updateStock() }}
    
    private var producers: [Producer] = []
    
    var delegate: ShoppingCartDelegate?

    var portions: Double = 0

    @IBAction func addPortionButtonPressed(_ sender: UIButton) {
        if stock!.amountOfCropPortionsAvailable > 0 {
            stock!.amountOfCropPortionsAvailable -= 1
            portions += 1
            stock?.amountOfCropsSelected += 1
        }
        updateStock()
        buttonsEnabled()
    }
    @IBAction func removePortionButtonPressed(_ sender: UIButton) {
        if portions == 0 {
            portions = 0
            stock?.amountOfCropsSelected -= 1
            //alert
        } else {
            portions -= 1
            stock!.amountOfCropPortionsAvailable += 1
            stock?.amountOfCropsSelected -= 1
        }
        updateStock()
    }
    
    private func buttonsEnabled(){
        
        guard let stock = stock else {return}
        if stock.amountOfCropPortionsAvailable > 0 {
            addPortionButton.isEnabled = true
        } else if stock.amountOfCropPortionsAvailable == 0 {
            addPortionButton.isEnabled = false
        }
        
        if portions > 0 {
            removePortionButton.isEnabled = true
        } else if portions == 0 {
            removePortionButton.isEnabled = false
        }
    }
    
    private func updateStock(){
        guard let stock = stock else {return}

        var totalPrice = portions * stock.sellingPrice
        print(stock.totalCostOfCropsSelected)
        numberOfCropPortionsAvailableLabel.text = String(stock.amountOfCropPortionsAvailable)
        pricingAndWeightPerPortionLabel.text = "\(stock.quantity.rawValue) \(stock.quantityTypes.rawValue) per portie. €\(stock.sellingPrice) per portie."
        cropNameLabel.text = stock.cropName.rawValue
        numberOfPortions.text = "\(portions)"
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
