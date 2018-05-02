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
    
    let locationManager = CLLocationManager()
    var pin: AnnotationPin!
    var otherPin: AnnotationPin!
    
    @IBOutlet weak var producersListHomePageTableView: UITableView! 
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    private let ward: Producer = Producer(companyName: "VeltWinkel", contact: Contact(name: Name(firstName: "Ward", lastName: "Janssen"), address: Address(streetName: "Guldentop", streetNumber: "23", postalCode: "3118", place: Place.werchter), telephoneNumber: "0495124115", emailAddress: "veltwinkel@gmail.com"), companyImage: nil, location: CLLocationCoordinate2D(latitude: 50.98, longitude: 4.75), delivery: true, mainProduce: MainProduce.vegetableFruitEggs, deliveryHours: Date(), pickUpHours: Date(), validation: 5)
    
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
        
        producers += [ward]
        
        locationManager.delegate = self
        requestLocationAccess()
        locationManager.startUpdatingLocation()
        show(locationManager.location)
        
        mapView.delegate = self
        
        
        pin = AnnotationPin(with: ward)
            
            
            mapView.addAnnotation(pin)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }else if annotation is AnnotationPin{
            let pinAnnotation = annotation as! AnnotationPin
            let annotationView = MKMarkerAnnotationView(annotation: pinAnnotation, reuseIdentifier: "")
            annotationView.glyphText = pinAnnotation.producer.mainProduce.rawValue
            annotationView.markerTintColor = pinAnnotation.annotationColor
            annotationView.titleVisibility = .visible
            return annotationView
        }else {
            return nil
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1/*producers.count*/
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producerCell = tableView.dequeueReusableCell(withIdentifier: "producersCell", for: indexPath)
        let producer = producers[indexPath.row]
        if let producerCell = producerCell as? ProducersTableViewCell {
            producerCell.producer = producer
        }
        return producerCell
    }
    
    //  MARK: tableView Delegate
    
    
    
}

