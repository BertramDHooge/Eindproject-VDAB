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
        
        for producer in producers {
            let pin = AnnotationPin(with: producer)
            mapView.addAnnotation(pin)
        }
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
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
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
    
    //  MARK: tableView Delegate
    
    // MARK: IBAction
    
    @IBAction func searchLocation(_ sender: UIButton) {
        showActivityIndicator(in: mapView)
        if let search = locationSearchField.text {
            searchMapLocation(for: search)
        }
        removeActivityIndicator()
    }
    
}

