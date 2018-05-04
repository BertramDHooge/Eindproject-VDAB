//
//  producerInfoTableViewCell.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 02/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class ProducerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var producerInfoTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
