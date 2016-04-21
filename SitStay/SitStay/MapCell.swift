//
//  MapCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/20/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit
import MapKit


class MapCell: UITableViewCell, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 500
    var locationManager = CLLocationManager()
    var chosenLocation: CLLocation? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        checkLocationAuthorizationStatus()
        if(map.showsUserLocation){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            print("Using Como location")
            let initialLocation = CLLocation(latitude: 38.949941, longitude: -92.330025)
            centerMapOnLocation(initialLocation)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            centerMapOnLocation(location)
            chosenLocation = location
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        print(location.coordinate.latitude)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - location manager to authorize user location for Maps app
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }


}
