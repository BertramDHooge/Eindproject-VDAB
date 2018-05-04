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


class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSearchField: UITextField!
    
    let locationManager = CLLocationManager()
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var producersListHomePageTableView: UITableView! 
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    var myIndex = 0
    // index of which cell pressed index 1 = producer 1
    
    private var producers: [Producer] = []
    
    
    var searchCityName: String? {
        didSet {
            producers.removeAll()
            producersListHomePageTableView.reloadData()
            //            searchForProducers()
            
        }
    }
    //    var currentLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Mark: Info Producers
        
        let adressMammoth = Address(streetName: "Ice Lane", streetNumber: 1, postalCode: 1333, place: Place.kesselLo)
        let mammothName = Name(firstName: "Mammoth", lastName: "Wooly")
        let infoMammoth = Contact(name: mammothName, address: adressMammoth, telephoneNumber: "123456789", emailAddress: "imAMammoth@cold.com")
        let mammothCrops = [Crop(cropType: FoodTypes.fruit, cropName: FoodName.apples, quantityTypes: QuantityTypes.Kg, quantity: Quantity._20, cost: 22, amountOfCropPortionsAvailable: "2000")]
        
        let bertramName = Name(firstName: "Bertram", lastName: "nenHooge")
        let adressBertram = Address(streetName: "ClosetoSchool", streetNumber: 1, postalCode: 1234, place: Place.leuven)
        let infoBertram = Contact(name: bertramName, address: adressBertram, telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com")
        let bertramCrops = [Crop(cropType: FoodTypes.meat, cropName: FoodName.cow, quantityTypes: QuantityTypes.Kg, quantity: Quantity._10, cost: 100, amountOfCropPortionsAvailable: "1")]
        
        // Mark: Producers
        
        //        let ward: Producer = Producer(companyName: "VeltWinkel", contact: Contact(name: Name(firstName: "Ward", lastName: "Janssen"), address: Address(streetName: "Guldentop", streetNumber: 1, postalCode: 3118, place: Place.werchter), telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com"), companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.98, longitude: 4.75), delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: 5)
        
        let mammothProducer = Producer(companyName: "Tolis", contact: infoMammoth, companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.748273, longitude: 4.346720), delivery: true, mainProduce: MainProduce.vegetableFruitDairy, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crops: mammothCrops)
        
        let bertramProducer = Producer(companyName: "VeltWinkel", contact: infoBertram, companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.749713, longitude: 4.347011), delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: nil, crops: bertramCrops)
        
        add(mammothProducer)
        add(bertramProducer)
        
        //        producers += [mammothProducer, bertramProducer]
        
        //        producers.append(Producer(companyName: "Hey", contact: Contact(name: Name(firstName: "IZ", lastName: "ME"), address: Address(streetName: "somestreet", streetNumber: "30", postalCode: "3001", place: Place.oudHeverlee), telephoneNumber: "Not gonna give you that", emailAddress: "nor this"), companyImage: "lol", location: (locationManager.location?.coordinate)!, delivery: false, mainProduce: MainProduce.dairy, deliveryHours: Date(), pickUpHours: Date(), validation: 5))
        
        //        ward.location = (locationManager.location?.coordinate)!
        
        producers.append(ward)
        
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
        
        // MARK: Made by Louis for shopping cart table view, please do not delete just put in "//"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        performSegue(withIdentifier: "producerCropsListSegue", sender: ProducersTableViewCell.self)
    }
    // adding to producers
    
    func add(_ producer: Producer){
        
        producers.append(producer)
    }
    
    // MARK: end content made by louis
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let pin = view.annotation as? AnnotationPin
        performSegue(withIdentifier: "initiateInfoVC", sender: pin?.producer)
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        show(locations.first!)
    //    }
    
    func show(_ location: CLLocation?) {
        if let location = location {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(region, animated: true)
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }
    
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
    
    
    //    MARK: tableView dataSource
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return producers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producerCell = tableView.dequeueReusableCell(withIdentifier: "producersCell", for: indexPath) as! ProducersTableViewCell
        let producer = producers[indexPath.row]
        producerCell.producer = producer
        return producerCell
    }
    
    func showActivityIndicator(in view: UIView){
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func searchMapLocation(for location: String) {
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = location
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil {
                //popup
                print("error")
            } else{
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    // MARK: tableView Delegate
    
    // MARK: IBAction
    
    @IBAction func searchLocation(_ sender: UIButton) {
        showActivityIndicator(in: mapView)
        if let search = locationSearchField.text {
            searchMapLocation(for: search)
        }
        removeActivityIndicator()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "producerCropsListSegue"{
            if let destinationVC = segue.destination as? ShoppingCartViewController{
                if let producer = sender as? Producer{
                    destinationVC.arrayOfProducerCrops = producer
                    
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

