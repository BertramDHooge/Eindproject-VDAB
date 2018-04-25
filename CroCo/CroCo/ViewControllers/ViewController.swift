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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var pin: AnnotationPin!
    
    //    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        show()
        
        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.32469731, longitude: -122.02020869)
        pin = AnnotationPin(title: "Apple Farm", subTitle: "That's right", coordinate: coordinate)
        mapView.addAnnotation(pin)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "testPin")
        annotationView.glyphText = "🍏"
        annotationView.titleVisibility = .visible
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        show(locations.first!)
    }
    
    func show(_ location: CLLocation) {
        
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
    }
    
}

