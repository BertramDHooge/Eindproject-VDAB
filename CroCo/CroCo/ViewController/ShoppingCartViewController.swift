//
//  ShoppingCartViewController.swift
//  CroCo
//
//  Created by Louis Loeckx on 25/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
//    var arrayOfProducers: [Producer] = []
    
    var producers: Producer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
                



        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return producers!.crops.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producersCropCell = tableView.dequeueReusableCell(withIdentifier: "producersCrop", for: indexPath)
        let crop = producers!.crops[indexPath.row]
        if let producersCropCell = producersCropCell as? CropTableViewCell {
            producersCropCell.crop = crop
        }
        // Configure the ...

        return producersCropCell
    }
 
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
