
//
//  CropTableViewCell.swift
//  CroCo
//
//  Created by Louis Loeckx on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

protocol ShoppingCartRequisite {
    func changeTotalAmount(by amountOfMoney: Double)
}

class CropTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCropPortionsAvailableLabel: UILabel!
    @IBOutlet weak var cropNameLabel: UILabel!
    
    @IBOutlet weak var pricingAndWeightPerPortionLabel: UILabel!
    @IBOutlet weak var totalNumberOfPortionsSelectedLabel: UILabel!
    
    @IBOutlet weak var addPortionButton: UIButton!
    @IBOutlet weak var removePortionButton: UIButton!
    @IBOutlet weak var numberOfPortions: UILabel!
    
    var stock: Stock? { didSet { updateCrops() }}
    
    var shoppingCartDelegate: ShoppingCartRequisite?
    
    private var producers: [Producer] = []

    var portions: Double = 0

    @IBAction func addPortionButtonPressed(_ sender: UIButton) {
        if stock!.amountOfCropPortionsAvailable > 0 {
            
            stock!.amountOfCropPortionsAvailable -= 1
            portions += 1
            stock?.amountOfCropsSelected += 1
            shoppingCartDelegate?.changeTotalAmount(by: +stock!.sellingPrice)
        }
        
        updateCrops()
    }
    @IBAction func removePortionButtonPressed(_ sender: UIButton) {
        if portions > 0 {
            
            stock!.amountOfCropPortionsAvailable += 1
            portions -= 1
            stock?.amountOfCropsSelected -= 1
            shoppingCartDelegate?.changeTotalAmount(by: -stock!.sellingPrice)
        }
        
        updateCrops()
    }
    
    private func updateCrops(){
        
        addPortionButton.isEnabled = !(stock!.amountOfCropPortionsAvailable == 0)
        removePortionButton.isEnabled = !(portions == 0)
        
//        shoppingCart!.TotalCost = portions * crop.sellingPrice
        numberOfCropPortionsAvailableLabel.text = String(stock!.amountOfCropPortionsAvailable)
        pricingAndWeightPerPortionLabel.text = "\(stock!.quantity.rawValue) \(stock!.quantityTypes.rawValue) per portie. €\(stock!.sellingPrice) per portie."
        cropNameLabel.text = stock!.cropName.rawValue
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
