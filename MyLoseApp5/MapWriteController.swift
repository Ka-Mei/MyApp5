//
//  MapWriteController.swift
//  MyLoseApp5
//
//  Created by 河村萌衣 on 2020/06/07.
//  Copyright © 2020 kawamuramei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapWriteController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var myMap: MKMapView!
    
    
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addressText.delegate = self
        
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.requestLocation()

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textField.text
        request.region = myMap.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            guard let myCoordinate = response.mapItems.first?.placemark.coordinate else {
                return
            }
           let region = MKCoordinateRegion(center: myCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.myMap.setRegion(region, animated: true)
        }
        textField.resignFirstResponder()
        return true
    }

    
}


extension MapWriteController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
                   locationManager.requestLocation()
               }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            myMap.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: (error)")
    }
}
