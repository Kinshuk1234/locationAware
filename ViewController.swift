//
//  ViewController.swift
//  Location Aware
//
//  Created by Kinshuk Singh on 2017-05-29.
//  Copyright © 2017 Ksk. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!

    @IBOutlet weak var course: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        self.latitude.text = String(location.coordinate.latitude)
        self.longitude.text = String(location.coordinate.longitude)
        self.course.text = String(location.course)
        self.speed.text = String(location.speed)
        self.altitude.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                
                print(error)
                
            }
            else {
                
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }

                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }

                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                    }

                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n "
                    }

                    if placemark.country != nil {
                        address += placemark.country! + "\n"
                    }
                    
                    self.address.text = address
                }
                
            }
        }
        
    }
    


}

