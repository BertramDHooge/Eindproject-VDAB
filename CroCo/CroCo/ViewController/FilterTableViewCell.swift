//
//  FilterTableViewCell.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 14/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var mainProduceLabel: UILabel!
    
    @IBOutlet weak var selectedStockButton: UIButton!
    
    var stockNotYetSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectedStockButtonPressed(_ sender: UIButton) {
        if stockNotYetSelected {
            selectedStockButton.setTitle("⚪️", for: .normal)
//            for producer in producers {
//                if producer.mianProduce.contains...
//            }
            stockNotYetSelected = false
        } else {
            selectedStockButton.setTitle("🔵", for: .normal)
            stockNotYetSelected = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
