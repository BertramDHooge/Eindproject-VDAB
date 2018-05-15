
//
//  CropTableViewCell.swift
//  CroCo
//
//  Created by Louis Loeckx on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import Firebase

class CropTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCropPortionsAvailableLabel: UILabel!
    @IBOutlet weak var cropNameLabel: UILabel!
    
    @IBOutlet weak var pricingAndWeightPerPortionLabel: UILabel!
    @IBOutlet weak var totalNumberOfPortionsSelectedLabel: UILabel!
    
    @IBOutlet weak var addPortionButton: UIButton!
    @IBOutlet weak var removePortionButton: UIButton!
    @IBOutlet weak var numberOfPortions: UILabel!
    
    var stock: Stock? { didSet { updateUI() }}
    
    var shoppingCartDelegate: ShoppingCartDelegate?
    
    private var producers: [Producer] = []

    var portions: Double = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /// Adds a single portion to the shopping cart
    @IBAction func addPortionButtonPressed(_ sender: UIButton) {
        
        if stock!.amountOfStockPortionsAvailable > 0 {
            
            stock!.amountOfStockPortionsAvailable -= 1
            portions += 1
            shoppingCartDelegate?.changeTotalAmount(by: +stock!.portion.sellingPriceSinglePortion)
        }
        
        updateUI()
    }
    
    /// Removes a single portion from the shopping cart
    @IBAction func removePortionButtonPressed(_ sender: UIButton) {
        
        if portions > 0 {
            
            stock!.amountOfStockPortionsAvailable += 1
            portions -= 1
            shoppingCartDelegate?.changeTotalAmount(by: -stock!.portion.sellingPriceSinglePortion)
        }
        
        updateUI()
    }
    
    /// Updates the UserInterface to conform to the data
    private func updateUI(){
        
        addPortionButton.isEnabled = !(stock!.amountOfStockPortionsAvailable == 0)
        removePortionButton.isEnabled = !(portions == 0)
        
        numberOfCropPortionsAvailableLabel.text = String(stock!.amountOfStockPortionsAvailable)
        pricingAndWeightPerPortionLabel.text = "€\(stock!.portion.sellingPriceSinglePortion) per portie."
        cropNameLabel.text = stock!.portion.portionDescription
        numberOfPortions.text = "\(portions)"
    }
    

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
