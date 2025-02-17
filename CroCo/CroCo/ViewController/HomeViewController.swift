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
    
    @IBOutlet weak var addProducerAndStockButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchField: UITextField!
    @IBOutlet weak var producersListHomePageTableView: UITableView!
    @IBOutlet weak var favoritedButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    //   MARK Global Variables
    
    let locationManager = CLLocationManager()
    
    var usedLocation: CLLocation?
    
    private let activityIndicator = UIActivityIndicatorView()
    
    var homeButtonSelected: Bool = true {
        didSet {
            updateHomeAndFilter()
            producersListHomePageTableView.reloadData()
        }
    }
    /// Index of the most recently pressed cell (defaults to 0 if no cells have been pressed)
    var myIndex = 0
    
    private var shoppingCart: ShoppingCart!
    
    var reference: CollectionReference!
    
    var usedProducers: [Producer] = [] {
        didSet {
            producersListHomePageTableView.reloadData()
        }
    }
    
    private var sortedProducers: [Producer] {
        if let location = usedLocation {
            return usedProducers.sorted(by: {(producer1, producer2) -> Bool in producer1.location!.distance(from: location) < producer2.location!.distance(from: location)})
        } else {
            return usedProducers
        }
    }
    
    var searchCityName: String? {
        didSet {
            producersListHomePageTableView.reloadData()
            //            searchForProducers()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoginAdministrators()
        
        let homebar = false
        if homebar {
            
            homeButton.isHidden = false
            filterButton.isHidden = false
        } else {
            
            homeButton.isHidden = true
            filterButton.isHidden = true
        }
        
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        //        rootReference = Database.database().reference()
        //        let producerReference = rootReference?.child("producer")
        //        producerReference?.setValue(["companyName":"Veltwinkel"])
        
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
        
        self.reference = Firestore.firestore().collection("Producers")
        self.reference.getDocuments(completion: { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let myData = snapshot.documents
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            for document in myData {
                let data = document.data()
                if let companyName = data["CompanyName"] as? String,
                    let contactFirstName = data["ContactFirstName"] as? String,
                    let contactLastName = data["ContactlastName"] as? String,
                    let email = data["EmailAddress"] as? String,
                    let place = data["Place"] as? String,
                    let postalCode = data["PostalCode"] as? Int,
                    let streetNumber = data["StreetNumber"] as? Int,
                    let streetName = data["StreetName"]as? String,
                    let telephoneNumber = data["TelephoneNumber"] as? String,
                    let stock = data["Stock"] as? [String: [String: Any]]{
                    
                    var stocks: [Stock] = []
                    
                    for (key, value) in stock{
                        
                        let sellingPrice = value["SellingPricePerPortion"] as! Double
                        let amount = value["AmountOfPortions"] as! Int
                        let stock = Stock(portion: Portion(portionDescription: key, sellingPriceSinglePortion: sellingPrice), amountOfStockPortionsAvailable: amount)
                        stocks.append(stock)
                    }
                    
                    let address = Address(streetName: streetName, streetNumber: streetNumber, postalCode: postalCode, place: place)
                    let contact = Contact(name: Name(firstName: contactFirstName, lastName: contactLastName), address: address, telephoneNumber: telephoneNumber, emailAddress: email)
                    
                    let searchRequest = MKLocalSearchRequest()
                    searchRequest.naturalLanguageQuery = address.fullAddress
                    
                    let activeSearch = MKLocalSearch(request: searchRequest)
                    activeSearch.start { (response, error) in
                        if let response = response {
                            
                            let latitude = response.boundingRegion.center.latitude
                            let longitude = response.boundingRegion.center.longitude
                            
                            let location = CLLocation(latitude: latitude, longitude: longitude)
                            
                            let producer = Producer(companyName: companyName, contact: contact, location: location, locationString: address.fullAddress, delivery: false, mainProduce: MainProduce.dairy, deliveryHours: "", pickUpHours: "", stocks: stocks)
                            
                            let pin = AnnotationPin(with: producer, and: (producer.location?.coordinate)!)
                            self.mapView.addAnnotation(pin)
                            
                            if !self.usedProducers.contains(where: { (usedProducer) -> Bool in
                                usedProducer.companyName == producer.companyName
                            }) {
                                
                                self.usedProducers.append(producer)
                            }
                        }
                    }
                }
            }
        })
    }
    
    
    
    // MARK: -Managing the MapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        } else if let pinAnnotation = annotation as? AnnotationPin{
            let annotationView = MKMarkerAnnotationView(annotation: pinAnnotation, reuseIdentifier: "")
            
            switch pinAnnotation.producer.mainProduce{
            case .dairy, .eggs, .fruit, .meat, .poultry, .vegetable:
                annotationView.glyphText = pinAnnotation.producer.mainProduce.rawValue
            default:
                annotationView.glyphText = "..."
            }
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
    // MARK: ???
    
    let MainProduceArray = ["Vegetable", "Fruit", "Dairy", "eggs", "Poultry", "meat"]

    
    // MARK: -Managing the TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeButtonSelected {
            return sortedProducers.count
        } else {
            return MainProduceArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifierName = "producersCell"
        updateHomeAndFilter()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierName, for: indexPath)
        
        if homeButtonSelected {
        cell.isHidden = false
        let producer = sortedProducers[indexPath.row]
        
            if let producerCell = cell as? ProducersTableViewCell {
                producerCell.isUserInteractionEnabled = true
                producerCell.accessibilityElementsHidden = true
                producerCell.producer = producer
                producerCell.adressLabel.text = producer.contact.address.fullAddress
                producerCell.companyNameLabel.text = producer.companyName
                producerCell.distanceFromLocationLabel.text = "\(Int(producer.location!.distance(from: usedLocation ?? locationManager.location!) / 1000)) km"
            }
            cell.backgroundColor = .clear
            return cell
        } else {
            let typesOfProduce = MainProduceArray[indexPath.row]
            if let typesOfProduceCell = cell as? ProducersTableViewCell {
                typesOfProduceCell.isUserInteractionEnabled = false
                typesOfProduceCell.accessibilityElementsHidden = false
                typesOfProduceCell.favoriteStarButton.isHidden = true
                typesOfProduceCell.adressLabel.isHidden = true
                typesOfProduceCell.companyNameLabel.text = typesOfProduce
                typesOfProduceCell.distanceFromLocationLabel.isHidden = true
            }
            cell.backgroundColor = .clear
            return cell
        }
//        return stockTypeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        //        tableView.prefetchDataSource = self
        performSegue(withIdentifier: "producerCropsListSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? ProducersTableViewCell {
            
            performSegue(withIdentifier: "initiateInfoVC", sender: cell.producer!)
        }
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
    
    @IBAction func addProducer(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addProducer", sender: self)
    }
    
    
    @IBAction func HomeButtonPressed(_ sender: UIButton) {
        homeButtonSelected = true
        updateHomeAndFilter()
    }
    
    @IBAction func FilterButtonPressed(_ sender: Any) {
        homeButtonSelected = false
        updateHomeAndFilter()
    }
    
    
    // MARK: Favorited?
    
    
    // MARK: update for home and filter button
    
    func updateHomeAndFilter(){
        if homeButtonSelected {
            homeButton.setImage(UIImage(named: "HomeSelected"), for: .normal)
            filterButton.setImage(UIImage(named: "Filtered"), for: .normal)
//            let identifierName = "producersCell"
//            return identifierName
        } else {
            homeButton.setImage(UIImage(named: "Home"), for: .normal)
            filterButton.setImage(UIImage(named: "FilteredSelected"), for: .normal)
//            let identifierName = "producersCell"
//            return identifierName
        }
        return
    }
    
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
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        
    }
    
    func checkLoginAdministrators() {
        if Auth.auth().currentUser?.email == "wardjanssen1968@gmail.com" || Auth.auth().currentUser?.email == "louis.loeckx@gmail.com" || Auth.auth().currentUser?.email == "bertramdhooge@gmail.com" {
            self.addProducerAndStockButton.isHidden = false
        } else {
            self.addProducerAndStockButton.isHidden = false
            
        }
    }
    
}


