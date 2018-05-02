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
    var title: String
    var info: String
    
    init(title: String, info: String) {
        self.title = title
        self.info = info
        super.init(style: .default, reuseIdentifier: "producerInfo")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoTitleLabel.text = title
        producerInfoTextField.text = info
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
