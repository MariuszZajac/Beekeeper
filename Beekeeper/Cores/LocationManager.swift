//
//  LocationManager.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import SwiftUI
import CoreLocation
//temporary

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    
    @Published var location: CLLocationCoordinate2D?
    var locationReceived: ((CLLocationCoordinate2D?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        locationReceived?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Błąd podczas pobierania lokalizacji", error)
    }
   
}
