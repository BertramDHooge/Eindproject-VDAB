//
//  stockViewController.swift
//  CroCo
//
//  Created by Ward Janssen on 10/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit

class stockViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
//    -My outlets
    
    @IBOutlet weak var cropName: UITextField!
    @IBOutlet weak var stockQuantity: UITextField!
    @IBOutlet weak var pricePerPortion: UITextField!
    
    var stock: Stock? = nil
    var delegate: AddStockDelegate?
    
    var cropNames = ["0.5 kg gekookte aardappeltjes", "1 stuk andijvie", "400 g aubergine", "20 g basilicum", "0.5 kg bewaarui", "20 g bieslook", "1 stuk bloemkool", "350 g boerenkool", "0.5 kg broccoli", "1 kg courgette", "200 g doperwt", "1 stuk groene selder", " knolselder", "1 stuk groenloof", "1 stuk ijsbergsla", "1 stuk knolselder", "450 g komkommer", "20 g koreander", "200 g kool en mosterdblaadjes", "700 g koolrabi", "1 stuk kropsla", "1 stuk krulsla", "700 g gele raap", "1 stuk mais", "50 g vriesmais", "1 stuk meloen", "0,5 kg baby leaf", "1 stuk chinese kool", "350 g palmkool", "250 g paprika", "350 g pastinaak", "20 g peper", "50 g peterselie", "50 g vrieserwt", "250 g peulerwt", "200 g suikererwt", "100 g pluksla babyleaf", "1 kg pompoen oranje", " pompoen spagetti", "50 g vriesprei", "1 kg prei", "350 g prei", "350 g prei", "bussel 16 stuks radijs", "1 stuk rammenas", "0.5 kg rode biet", "1 stuk rode kool", "bussel 8 stuks raapstelen", "bussel 4 stuks rabarber", "200 g rucola", "1 stuk savooikool", "1 kg schorseneer", "250 g slamix", "100 g warmoes swiss chard", "400 g spinazie", " spinazie baby leaf", "400 g spruitkool", "0,5 kg staakboon", "4 stuks stengelui", "0.5 kg struikboon", "50 g suikermais", "400 g tomaat coeur de boeuf", "400 g tomaat rond", "400 g tomaat trostomaat", "250 g tuinboon", "3 stuks venkel", "100 g veldsla", "0.5 kg winterwortel", "1 stuk witte kool", "bussel 12 stuks zomerwortel", "100 g zuring", " watermeloen", " biet", " bok choy", " dille", "0.5 kg snijboon", "100 g Mizuna", "250 g baby carrots", "3 stuks lookstelen", "3 stuks wortelpeterselie", "3 stuks look ", "1 kg ajuin", "500 g tuinbonen", "1 stuk venkel", "1 stuk pompoen butternut", "20 g KRUIDEN", " 100 g komkommerkruid", "20 g Dille", "20 g Basilicum" ]
    
    var stockQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", ]
    
    var cropPickerView = UIPickerView()
    var quantityPickerView = UIPickerView()
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cropPickerView {return cropNames.count}
        else {return stockQuantities.count}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cropPickerView {return cropNames[row]}
        return stockQuantities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cropPickerView {cropName.text = cropNames[row]}
        stockQuantity.text = stockQuantities[row]
    }
    
    
//    var onSave: (([_ foodtype: String,_ cropName: String,_ quantity: Int,_ quantityType: String,_ stockPortionsAmount: Int,_ pricePerPortion: Double])->())?
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropPickerView.dataSource = self
        cropPickerView.delegate = self

        quantityPickerView.dataSource = self
        quantityPickerView.delegate = self
        
        cropName.inputView = cropPickerView
        cropName.placeholder = "Kies je product"
        
        stockQuantity.inputView = quantityPickerView
        stockQuantity.placeholder = "Kies het aantal porties in je voorraad"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        if let cropName = cropName.text, !cropName.isEmpty,  let stockQuantity = stockQuantity.text, !stockQuantity.isEmpty, let pricePerPortion = pricePerPortion.text, !pricePerPortion.isEmpty {
            
            stock = Stock(portion: Portion(stockName: StockName(rawValue: cropName)!, stockType: StockTypes.fruit, standardisedQuantitySingleStockType: QuantityTypes.kg, totalPortionsInStock: Int(stockQuantity)!, sellingPriceSinglePortion: Double(pricePerPortion)!), amountOfStockPortionsAvailable: 9, amountOfStockSelected: 5, totalCostOfSelectedStock: 60.0)
            delegate?.addStock(stock!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
 
}
