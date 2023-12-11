//
//  AddressViewModel.swift
//  Tasawaq
//
//  Created by Salma on 07/12/2023.
//

import CoreLocation
import MapKit

class LocationViewModel{
    let locationManager = CLLocationManager()
    var userLLocation: CLLocation?
    var searchAnnotation: MKPointAnnotation?
    var userAnnotation: MKPointAnnotation?
}
