//
//  Extensions.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 07/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import UIKit
import MapKit

extension UIView{
    
    /// Shows an activityIndicator in the current view while a task is being executed
    ///
    /// - Parameters:
    ///   - activity: The activityIndicator that will be shown
    ///   - completion: The task that will be performed while the activityindicator is shown
    func showActivity(_ activity: UIActivityIndicatorView, completion: (() -> Void)? ){
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        activity.center = self.center
        activity.hidesWhenStopped = true
        activity.color = .gray
        self.addSubview(activity)
        activity.startAnimating()
        
        if let completion = completion {
            completion()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            activity.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
    }
    
}

extension MKMapView{
    
    /// Shows a location on the map
    ///
    /// - Parameter location: The location that will be shown
    func show(_ location: CLLocation?) {
        
        if let location = location {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.setRegion(region, animated: true)
        }
    }
    
    /// Converts an inserted string to a location (when possible) and shows this location on the map
    ///
    /// - Parameter location: The String you want to have converted to a location
    func searchAndShowMapLocation(for location: String){
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = location
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if let response = response {
                
                let latitude = response.boundingRegion.center.latitude
                let longitude = response.boundingRegion.center.longitude
                
                self.show(CLLocation(latitude: latitude, longitude: longitude))
            }
        }
    }
}

