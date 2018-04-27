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
   
    
    private var producers: [Producer] = [] {
        didSet {
        producersListHomePageTableView.reloadData()

        }
    }
 
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
        
        locationManager.delegate = self
        requestLocationAccess()
        locationManager.startUpdatingLocation()
        show(locationManager.location)
        
        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.32469731, longitude: -122.02020869)
        pin = AnnotationPin(with: Producer(companyName: "Boer Jos", contact: Contact(name: Name(firstName: "Jos", lastName: ""), address: Address(streetName: "Meh", streetNumber: "123", postalCode: "3001", place: .betekom), telephoneNumber: "321", emailAddress: ""), companyImage: "Joske", description: "Ik ben een boer", location: coordinate, delivery: true, mainProduce: .poultry, deliveryHours: Date(), pickUpHours: Date(), favorite: true))
        let otherCoordinate = CLLocationCoordinate2D(latitude: 37, longitude: -122)
        otherPin = AnnotationPin(with: Producer(companyName: "Boer Jef", contact: Contact(name: Name(firstName: "mkj", lastName: "mkj"), address: Address(streetName: "Aspergerijstraat", streetNumber: "23", postalCode: "3118", place: .oudHeverlee), telephoneNumber: "12", emailAddress: "wardjanssen1968@gmail.com"), companyImage: "Jefke", description: "Ik ben ook een boer", location: otherCoordinate, delivery: false, mainProduce: .meat, deliveryHours: Date(), pickUpHours: Date(), favorite: false))
        mapView.addAnnotation(otherPin)
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
        return producers.count
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

