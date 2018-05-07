//
//  Extensions.swift
//  CroCo
//
//  Created by Bertram D'Hooge on 07/05/2018.
//  Copyright © 2018 VDAB. All rights reserved.
//

import Foundation

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
        activity.startAnimating()
        
        if let completion = completion {
            completion()
        }
        
        activity.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
