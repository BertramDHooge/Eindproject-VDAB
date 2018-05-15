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
    
    var favorited: Bool = false
    
    @IBOutlet weak var distanceFromLocationLabel: UILabel!
    @IBOutlet weak var bikeDeliveryLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var favoriteStarButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteStarButton(_ sender: UIButton) {
        if favorited == false {
            sender.setTitle("★", for: .normal)
            favoriteStarButton.setTitleColor(UIColor.orange, for: .normal)
            favorited = true
            print("left")
        } else {
            favoriteStarButton.setTitle("☆", for: .normal)
            favoriteStarButton.setTitleColor(UIColor.orange, for: .normal)
            favorited = false
            print("right")
        }
    }

    /// Updates the UserInterface to conform to the data
    private func updateUI() {
        guard let producer = producer else {return}
        if producer.delivery == false {
            bikeDeliveryLabel.text = ""
        } else {
            return
        }
        companyNameLabel.text = producer.companyName ?? producer.contact.name.firstName
        adressLabel.text = producer.contact.address.fullAddress
    }
}
