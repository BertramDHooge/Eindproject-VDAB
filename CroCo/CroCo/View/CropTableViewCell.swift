
//
//  CropTableViewCell.swift
//  CroCo
//
//  Created by Louis Loeckx on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class CropTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCropPoprtionsAvailableLabel: UILabel!
    
    @IBOutlet weak var cropNameLabel: UILabel!
    
    @IBOutlet weak var pricingAndWeightPerPortionLabel: UILabel!
    
    @IBOutlet weak var totalNumberOfPortionsSelectedLabel: UILabel!
    
    @IBOutlet weak var addPortionButton: UIButton!
    
    @IBOutlet weak var removePortionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
