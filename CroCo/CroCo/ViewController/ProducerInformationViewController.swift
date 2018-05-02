//
//  ProducerInformationViewController.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class ProducerInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var producerImageView: UIImageView!
    let producer: Producer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let producer = producer {
//            producerDescriptionTextView.text = producer.description
//            producerAddressTextView.text = producer.contact.address.description
//            producerFocusTextView.text = producer.mainProduce.rawValue.map({ (character) -> String in return String(character) + " "}).reduce("", +)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = ProducerInfoTableViewCell(title: "Description", info: (producer?.description)!)
            return cell
        case 2:
            let cell = ProducerInfoTableViewCell(title: "Address", info: (producer?.contact.address.description)!)
            return cell
        case 3:
            let cell = ProducerInfoTableViewCell(title: "Focus", info: (producer?.mainProduce.rawValue.map({ (character) -> String in return String(character) + " "}).reduce("", +))!)
            return cell
        case 4:
            let cell = DeliveryInfoTableViewCell()
            cell.deliveryInfoImageView.image = (producer?.delivery)! ? UIImage(named: "OK") : UIImage(named: "X")
            return cell
        default:
            return UITableViewCell()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
