//
//  ProducersTableViewCell.swift
//  CroCo
//
//  Created by Ward on 26/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class ProducersTableViewCell: UITableViewCell {
    var producer: Producer? {
        didSet { updateUI() }
    }
    

    @IBOutlet weak var bikeDeliveryLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteStarButton(_ sender: UIButton) {
        
    }
    
    private func updateUI() {
        guard let producer = producer else {return}
        if producer.delivery == false {
            bikeDeliveryLabel.text = ""
        } else {
            return
        }
        companyNameLabel.text = producer.companyName ?? producer.contact.name.firstName
        adressLabel.text = producer.contact.address.fullAdress
    }
}
