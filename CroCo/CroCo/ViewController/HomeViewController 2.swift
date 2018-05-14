//
//  ViewController.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 24/04/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    //   protocol nog invoegen: UITableViewDataSourcePrefetching
    
    //    MARK: -Prefetching data
    
    //    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    //        <#code#>
    //    }
    //    weak open var prefetchDataSource: UITableViewDataSourcePrefetching?
    
    
    //MARK: -Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchField: UITextField!
    @IBOutlet weak var producersListHomePageTableView: UITableView!
    @IBOutlet weak var favoritedButton: UIButton!
    
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    //   MARK Global Variables
    
    let locationManager = CLLocationManager()
    
    var usedLocation: CLLocation? = nil
    
    private let activityIndicator = UIActivityIndicatorView()
    
    /// Index of the most recently pressed cell (defaults to 0 if no cells have been pressed)
    var myIndex = 0
    
    private var shoppingCart: ShoppingCart!
    
    private var firebaseDemoProducers: [Producer] = []
    
    var usedProducers: [Producer] = []
    
    private var sortedProducers: [Producer] {
        if let location = usedLocation {
            return usedProducers.sorted(by: {(producer1, producer2) -> Bool in producer1.location.distance(from: location) < producer2.location.distance(from: location)})
        } else {
            return usedProducers
        }
    }
    
    var searchCityName: String? {
        didSet {
            firebaseDemoProducers.removeAll()
            producersListHomePageTableView.reloadData()
            //            searchForProducers()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let settings = FirestoreSettings()
//
//        Firestore.firestore().settings = settings
//
//        dataBase = Firestore.firestore()
        
        activityIndicator.activityIndicatorViewStyle = .gray
        
        //        rootReference = Database.database().reference()
        //        let producerReference = rootReference?.child("producer")
        //        producerReference?.setValue(["companyName":"Veltwinkel"])
        
        let mammothName = Name(firstName: "Mammoth", lastName: "Wooly")
        let locationmammot = CLLocation(latitude: 50.748273, longitude: 4.346720)
        let adressMammoth = Address(streetName: "Ice Lane", streetNumber: 1, postalCode: 1333, place: "Kessel Lo")
        let infoMammoth = Contact(name: mammothName, address: adressMammoth, telephoneNumber: "123456789", emailAddress: "imAMammoth@cold.com")
        let mammothCrops = [Stock(portion: Portion(portionDescription: "bussel van 3 keukenraap", sellingPriceSinglePortion: 1), amountOfStockPortionsAvailable: 100, amountOfStockSelected: 0, totalCostOfSelectedStock: 0.0)]
        //        (cropType: FoodTypes.fruit, cropName: FoodName.apples, quantityTypes: QuantityTypes.kg, quantity: Quantity._20, sellingPrice: 22, amountOfCropPortionsAvailable: 2000, amountOfCropsSelected: 0, totalCostOfCropsSelected: 0.0)]
        
        let bertramName = Name(firstName: "Bertram", lastName: "nenHooge")
        let locationFarmBertram = CLLocation(latitude: 50.749713, longitude: 4.347011)
        let adressBertram = Address(streetName: "ClosetoSchool", streetNumber: 1, postalCode: 1234, place: "Leuven")
        let infoBertram = Contact(name: bertramName, address: adressBertram, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let bertramCrops = [Stock(portion: Portion(weight: 12, typeOfWeight: "Bussel", stockName: "wortelen", sellingPriceSinglePortion: 1.5), amountOfStockPortionsAvailable: 50, amountOfStockSelected: 0, totalCostOfSelectedStock: 0.0)]
        
        let veltWinkelName = Name(firstName: "Ward", lastName: "Janssen")
        let locationVeltWinkel = CLLocation(latitude: 50.9794442, longitude: 4.7503198)
        let adresVeltWinkel = Address(streetName: "Guldentop", streetNumber: 1, postalCode: 3118, place: "Werchter")
        let veltWinkelInfo = Contact(name: veltWinkelName, address: adresVeltWinkel, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let veltWinkelCrops = [Stock(portion: Portion(weight: 2, typeOfWeight: "Kg", stockName: "Bintjes", sellingPriceSinglePortion: 1), amountOfStockPortionsAvailable: 30, amountOfStockSelected: 0, totalCostOfSelectedStock: 0.0)]
        
        let VeltWinkelProducer: Producer = Producer(companyName: "Veltwinkel", contact: veltWinkelInfo, location: locationVeltWinkel, locationString: "Guldentop 23, Werchter", delivery: true, mainProduce: .vegetable, deliveryHours: "zaterdag tussen 10.00 en 12.00", pickUpHours: "vrijdag tussen 18.00 en 20.00", stocks: veltWinkelCrops)
        
        let mammothProducer: Producer = Producer(companyName: "Tolis", contact: infoMammoth, location: locationmammot, locationString: "Brussel", delivery: true, mainProduce: MainProduce.fruit, deliveryHours: "zaterdag tussen 10.00 en 12.00", pickUpHours: "vrijdag tussen 18.00 en 20.00", stocks: mammothCrops)
        
        let bertramProducer: Producer = Producer(companyName: "POOP", contact: infoBertram, location: locationFarmBertram, locationString: "Oud Heverlee", delivery: false, mainProduce: MainProduce.meat, deliveryHours: "zaterdag tussen 10.00 en 12.00", pickUpHours: "vrijdag tussen 18.00 en 20.00", stocks: bertramCrops)
        
        firebaseDemoProducers.append(mammothProducer)
        firebaseDemoProducers.append(bertramProducer)
        firebaseDemoProducers.append(VeltWinkelProducer)
        
        locationManager.delegate = self
        requestLocationAccess()
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
            mapView.show(locationManager.location)
        case .denied, .restricted:
            
            print("location access denied")
        default:
            
            requestLocationAccess()
        }
        
        mapView.delegate = self
        
        for producer in firebaseDemoProducers {
            
            let searchRequest = MKLocalSearchRequest()
            searchRequest.naturalLanguageQuery = producer.locationString
            
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start { (response, error) in
                if let response = response {
                    
                    let latitude = response.boundingRegion.center.latitude
                    let longitude = response.boundingRegion.center.longitude
                    
                    self.usedProducers.append(Producer(companyName: producer.companyName, contact: producer.contact, location: CLLocation(latitude: latitude, longitude: longitude), locationString: producer.locationString, delivery: producer.delivery, mainProduce: producer.mainProduce, deliveryHours: producer.deliveryHour!, pickUpHours: producer.pickUpHour!, stocks: producer.stocks))
                    
                    let pin = AnnotationPin(with: producer, and: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    self.mapView.addAnnotation(pin)
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        producersListHomePageTableView.showActivity(activityIndicator) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                self.producersListHomePageTableView.reloadData()
            }
        }
    }
    
    
    // MARK: -Firestore
//
//    let mammothName = Name(firstName: "Mammoth", lastName: "Wooly")
//    let locationmammot = CLLocation(latitude: 50.748273, longitude: 4.346720)
//    let adressMammoth = Address(streetName: "Ice Lane", streetNumber: 1, postalCode: 1333, place: "Kessel Lo")
//    let infoMammoth = Contact(name: mammothName, address: adressMammoth, telephoneNumber: "123456789", emailAddress:
//
    
//     let bertramProducer: Producer = Producer(companyName: "PopcornParty", contact: infoBertram, location: locationFarmBertram, locationString: "Oud Heverlee", delivery: false, mainProduce: MainProduce.meat, deliveryHours: "zaterdag tussen 10.00 en 12.00", pickUpHours: "vrijdag tussen 18.00 en 20.00", stocks: [Stock(portion: Portion(portionDescription: "bos aardbeien", sellingPriceSinglePortion: 2.0), amountOfStockPortionsAvailable: 10, amountOfStockSelected: 1, totalCostOfSelectedStock: 2)])
   
    // MARK: -Managing the MapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        } else if let pinAnnotation = annotation as? AnnotationPin{
            let annotationView = MKMarkerAnnotationView(annotation: pinAnnotation, reuseIdentifier: "")
            annotationView.glyphText = pinAnnotation.producer.mainProduce.rawValue
            annotationView.markerTintColor = pinAnnotation.annotationColor
            annotationView.titleVisibility = .visible
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return annotationView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        usedLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        producersListHomePageTableView.reloadData()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let pin = view.annotation as? AnnotationPin
        performSegue(withIdentifier: "initiateInfoVC", sender: pin?.producer)
    }
    
    /// Requests whether or not the users current location can be used
    func requestLocationAccess() {
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // MARK: -Managing the TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedProducers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let producerCell = tableView.dequeueReusableCell(withIdentifier: "producersCell", for: indexPath)
        let producer = sortedProducers[indexPath.row]
        
        if let producerCell = producerCell as? ProducersTableViewCell {
            
            producerCell.producer = producer
            producerCell.adressLabel.text = producer.contact.address.fullAdress
            producerCell.companyNameLabel.text = producer.companyName
            producerCell.distanceFromLocationLabel.text = "\(Int(producer.location.distance(from: usedLocation ?? locationManager.location!) / 1000)) km"
        }
        producerCell.backgroundColor = .clear
        return producerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        //        tableView.prefetchDataSource = self
        performSegue(withIdentifier: "producerCropsListSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "initiateInfoVC", sender: firebaseDemoProducers[indexPath.row])
    }
    
    
    // MARK: -IBActions
    
    /// Function that is called whenever the user taps the search (🔍) button
    ///
    /// - Parameter sender: The tapped button (currently unused in the function)
    @IBAction func searchLocation(_ sender: UIButton) {
        
        mapView.showActivity(activityIndicator) {
            if let search = self.locationSearchField.text {
                
                self.mapView.searchAndShowMapLocation(for: search)
            }
        }
    }
    
    @IBAction func UnwindSegue(_ sender: UIStoryboardSegue){
        
    }
    
    @IBAction func addProducer(_ sender: UIButton) {
        performSegue(withIdentifier: "addProducer", sender: self)
    }
    
    // MARK: Favorited?
    
    
    
    
    
    // MARK: -Navigation Control
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "producerCropsListSegue" {
            if let destinationVC = segue.destination as? ShoppingCartViewController {
                if let producer = sender as? ProducersTableViewCell {
                    destinationVC.producer = producer.producer!
                }
            }
        } else if segue.identifier == "initiateInfoVC"{
            if let destinationVC = segue.destination as? ProducerInformationViewController{
                if let producer = sender as? Producer{
                    destinationVC.producer = producer
                }
            }
        }
    }
    
}


