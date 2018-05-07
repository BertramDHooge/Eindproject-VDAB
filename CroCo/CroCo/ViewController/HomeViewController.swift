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
    
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    //   MARK Global Variables
    private var rootReference: DatabaseReference?
    
    
    let locationManager = CLLocationManager()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    /// Index of the most recently pressed cell (defaults to 0 if no cells have been pressed)
    var myIndex = 0
    /// An array of producers
    private var producers: [Producer] = []
    /// @TODO
    var searchCityName: String? {
        didSet {
            producers.removeAll()
            producersListHomePageTableView.reloadData()
            //            searchForProducers()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityIndicator.activityIndicatorViewStyle = .gray
        
        rootReference = Database.database().reference()
        let producerReference = rootReference?.child("producer")
        producerReference?.setValue(["companyName":"Veltwinkel"])
        
        let mammothName = Name(firstName: "Mammoth", lastName: "Wooly")
        let locationmammot = CLLocation(latitude: 50.748273, longitude: 4.346720)
        let adressMammoth = Address(streetName: "Ice Lane", streetNumber: 1, postalCode: 1333, place: Place.kesselLo)
        let infoMammoth = Contact(name: mammothName, address: adressMammoth, telephoneNumber: "123456789", emailAddress: "imAMammoth@cold.com")
        let mammothCrops = [Crop(cropType: FoodTypes.fruit, cropName: FoodName.apples, quantityTypes: QuantityTypes.Kg, quantity: Quantity._20, cost: 22, amountOfCropPortionsAvailable: 2000)]
        
        let bertramName = Name(firstName: "Bertram", lastName: "nenHooge")
        let locationFarmBertram = CLLocation(latitude: 50.749713, longitude: 4.347011)
        let adressBertram = Address(streetName: "ClosetoSchool", streetNumber: 1, postalCode: 1234, place: Place.leuven)
        let infoBertram = Contact(name: bertramName, address: adressBertram, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let bertramCrops = [Crop(cropType: FoodTypes.meat, cropName: FoodName.cow, quantityTypes: QuantityTypes.Kg, quantity: Quantity._10, cost: 100, amountOfCropPortionsAvailable: 8)]
        
        
        let veltWinkelName = Name(firstName: "Ward", lastName: "Janssen")
        let locationVeltWinkel = CLLocation(latitude: 50.9794442, longitude: 4.7503198)
        let adresVeltWinkel = Address(streetName: "Guldentop", streetNumber: 1, postalCode: 3118, place: Place.werchter)
        let veltWinkelInfo = Contact(name: veltWinkelName, address: adresVeltWinkel, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let veltWinkelCrops = [Crop(cropType: FoodTypes.vegetable, cropName: FoodName.tomatoes, quantityTypes: QuantityTypes.Kg, quantity: Quantity._10, cost: 22, amountOfCropPortionsAvailable: 100)]
        
        let VeltWinkelProducer: Producer = Producer(companyName: "VeltWinkel", contact: veltWinkelInfo, companyImage: nil, location:locationVeltWinkel, delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: 5, crops: veltWinkelCrops)
        
        let mammothProducer = Producer(companyName: "Tolis", contact: infoMammoth, companyImage: nil, location: locationmammot, delivery: true, mainProduce: MainProduce.vegetableFruitDairy, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crops: mammothCrops)
        
        let bertramProducer = Producer(companyName: "VeltWinkel", contact: infoBertram, companyImage: nil, location: locationFarmBertram, delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crops: bertramCrops)
        
        producers.append(mammothProducer)
        producers.append(bertramProducer)
        producers.append(VeltWinkelProducer)
        
        locationManager.delegate = self
        requestLocationAccess()
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
            show(locationManager.location)
        case .denied, .restricted:
            
            print("location access denied")
        default:
            
            requestLocationAccess()
        }
        
        mapView.delegate = self
        
        for producer in producers {
            
            let pin = AnnotationPin(with: producer)
            mapView.addAnnotation(pin)
        }
    }
    
    
    // MARK: -Managing the MapView
    
    /// Defines the look of the annotations on the map (one by one) by returning an (optional) annotationView
    ///
    /// - Parameters:
    ///   - mapView: The Mapview in which the annotations are located
    ///   - annotation: The current annotation for which the look is being defined
    /// - Returns: The annotationView that you want to be shown on the map
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
    
    /// Function that is called whenever the user taps the accessoryItem (more info) on an annotationView, segues to ProducerInformationViewController while providing the necessary values
    ///
    /// - Parameters:
    ///   - mapView: The mapview in which work is being done
    ///   - view: The annotationView in which the accessoryItem was tapped
    ///   - control: The tapped Accessory (unused)
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let pin = view.annotation as? AnnotationPin
        performSegue(withIdentifier: "initiateInfoVC", sender: pin?.producer)
    }
    
    /// Converts an inserted string to a location (when possible) and shows this location on the map
    ///
    /// - Parameter location: The String you want to have converted to a location
    func searchMapLocation(for location: String) {
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = location
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if let response = response {
                
                let latitude = response.boundingRegion.center.latitude
                let longitude = response.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                self.show(CLLocation(latitude: latitude, longitude: longitude))
            }
        }
    }
    
    /// Shows a location on the map
    ///
    /// - Parameter location: The location that will be shown
    func show(_ location: CLLocation?) {
        
        if let location = location {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(region, animated: true)
        }
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
    
    /// Determines the amount of cells per section (section by section)
    ///
    /// - Parameters:
    ///   - tableView: The tableView in which the sections are located
    ///   - section: The current section
    /// - Returns: The amount of cell that is desired in the current section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return producers.count
    }
    
    /// Determines the way the cells in the tableView are shown (cell by cell)
    ///
    /// - Parameters:
    ///   - tableView: The tableView in which the cells are located
    ///   - indexPath: The indexPath for the current cell
    /// - Returns: The shown cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let producerCell = tableView.dequeueReusableCell(withIdentifier: "producersCell", for: indexPath) 
        let producer = producers[indexPath.row]
        
        if let producerCell = producerCell as? ProducersTableViewCell {
            
            producerCell.producer = producer
            producerCell.adressLabel.text = producer.contact.address.fullAdress
            producerCell.companyNameLabel.text = producer.companyName
        }
        producerCell.backgroundColor = .clear
        return producerCell
    }
    
    /// Function that is called whenever the user selects a cell in the tableView
    ///
    /// - Parameters:
    ///   - tableView: The tableView in which the selected cell is located
    ///   - indexPath: The indexPath for the selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        //        tableView.prefetchDataSource = self
        performSegue(withIdentifier: "producerCropsListSegue", sender: self)
    }
    
    /// Function that is called whenever the user presses the accessory item in a tableViewCell, segues to ProducerInformationViewController while providing the necessary values
    ///
    /// - Parameters:
    ///   - tableView: The tableView in which the cell with the accessoryItem is located
    ///   - indexPath: The indexPath for the cell in which the accessoryItem is located
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "initiateInfoVC", sender: producers[indexPath.row])
    }
    
    
    // MARK: -IBActions
    
    /// Function that is called whenever the user taps the search (🔍) button
    ///
    /// - Parameter sender: The tapped button (currently unused in the function)
    @IBAction func searchLocation(_ sender: UIButton) {
        
        mapView.showActivity(activityIndicator) {
            if let search = self.locationSearchField.text {
                self.searchMapLocation(for: search)
            }
        }
    }
    
    // MARK: -Navigation Control
    
    /// Function that is called whenever the application segues away from the current ViewController
    ///
    /// - Parameters:
    ///   - segue: The segue that will be performed
    ///   - sender: The object that activated the segue (currently used for datatransferring)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "producerCropsListSegue" {
            if let destinationVC = segue.destination as? ShoppingCartViewController {
                if let producer = sender as? ProducersTableViewCell {
                    destinationVC.producers = producer.producer
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


