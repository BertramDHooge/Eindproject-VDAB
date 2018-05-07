
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
    
    var crop: Crop? {
        didSet {
            updateCrops()
        }
    }
    
    var portions = 0

    @IBAction func addPortionButtonPressed(_ sender: UIButton) {
        
        if portions == 0 {
            crop!.amountOfCropPortionsAvailable -= 1
            portions += 1
        } else {
            portions += 1
            crop!.amountOfCropPortionsAvailable -= 1
        }
        updateCrops()
    }
    @IBAction func removePortionButtonPressed(_ sender: UIButton) {
        
        if portions == 0 {
            portions = 0
            //alert
        } else {
            portions -= 1
            crop!.amountOfCropPortionsAvailable += 1
        }
        updateCrops()
    }
    
    private func updateCrops(){
        guard let crop = crop else { return }
        
        if crop.amountOfCropPortionsAvailable > 0 {
            addPortionButton.isEnabled = true
        } else if crop.amountOfCropPortionsAvailable == 0 {
            addPortionButton.isEnabled = false
        }
        
        if portions > 0 {
            removePortionButton.isEnabled = true
        } else if portions == 0 {
            removePortionButton.isEnabled = false
        }
        
        numberOfCropPortionsAvailableLabel.text = String(crop.amountOfCropPortionsAvailable)
        pricingAndWeightPerPortionLabel.text = "\(crop.quantity.rawValue) \(crop.quantityTypes.rawValue) per portie. €\(crop.cost) per portie."
        cropNameLabel.text = crop.cropName.rawValue
        numberOfPortions.text = "\(portions)"
        
    }
    
    private var producers: [Producer] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
