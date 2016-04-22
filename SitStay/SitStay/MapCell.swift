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
    var add1: String?
    var city: String?
    var zip: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        if let add1 = add1{
            if let city = city{
                if let zip = zip{
                    updateLocation()
                    return
                }
            }
        }
            let initialLocation = CLLocation(latitude: 38.949941, longitude: -92.330025)
            centerMapOnLocation(initialLocation)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        print(location.coordinate.latitude)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func updateLocation(){
        if let add1 = add1{
            print("Map has add1")
            if let city = city{
                print("Map has city")
                if let zip = zip{
                    print("Map has zip")
                    print("Ready to update map")
                    let geocoder: CLGeocoder = CLGeocoder()
                    let location = (add1 + ", " + city + ", " + String(zip))
                    geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                        if (placemarks?.count > 0) {
                            let topResult: CLPlacemark = (placemarks?[0])!
                            let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                            var region: MKCoordinateRegion = self.map.region
                            
                            let latitude = (placemark.location?.coordinate.latitude)!
                            let longitude = (placemark.location?.coordinate.longitude)!
                            
                            let foundLocation = CLLocation(latitude: latitude, longitude: longitude)
                            
                            //region.span = MKCoordinateSpanMake(0.5, 0.5)
                            
                            //self.map.setRegion(region, animated: true)
                            self.centerMapOnLocation(foundLocation)
                            self.map.addAnnotation(placemark)
                        }
                    })
                }
            }
        }
    }


}
