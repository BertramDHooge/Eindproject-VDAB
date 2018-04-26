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
//        show()
        
        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.32469731, longitude: -122.02020869)
        pin = AnnotationPin(with: Producer(companyName: "Boer Jos", producerName: "Jos", companyImage: "Joske", description: "Ik ben een boer", address: coordinate, delivery: true, mainProduce: .vegetable, openHours: "Always"))
        mapView.addAnnotation(pin)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Stuff")
        annotationView.glyphText = pin.producer.mainProduce.rawValue
//        annotationView.glyphText = "🍏"
//        annotationView.titleVisibility = .visible
        return annotationView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        show(locations.first!)
    }
    
    func show(_ location: CLLocation) {
        
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
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
        producers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //  MARK: tableView Delegate
    

    
}

