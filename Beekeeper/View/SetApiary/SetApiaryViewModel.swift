//
//  SetApiaryViewModel.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 18/08/2023.
//

import Foundation
import CoreLocation

class SetApiaryViewModel: ObservableObject {
    @Published var apiaryName = ""
    @Published var apiaryOwner = ""
    @Published var selectedLocation: ApiaryLocation?
    @Published var address = ""
    @Published var apiary = [Apiary]()
   // @Published var apiaries: [Apiary] = []
    
   //let manager = UserDefaultsManager()
    
    init() {
        loadApiaries()
    }

    func loadApiaries() {
        apiary = Apiary.loadApiaries()
    }


    enum ApiaryError: Error {
        case noSelectedLocation
    }
    

    func createApiary() throws -> Apiary {
        print("Nazwa pasieki: \(apiaryName)")
        print("Właściciel pasieki: \(apiaryOwner)")
        print("Adres: \(address)")
        guard let selectedLocation = selectedLocation else {
            throw ApiaryError.noSelectedLocation
        }
        print("Wybrana lokalizacja: \(selectedLocation)")
        
        let newApiary = Apiary(id: UUID(), apiaryName: apiaryName, apiaryLocation: selectedLocation, apiaryOwner: apiaryOwner)
           apiary.append(newApiary)
        Apiary.saveApiaries(apiary)

        return newApiary
    }


    
    
    func getCoordinatesFromAddress(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Nie udało się uzyskać współrzędnych dla adresu: \(address)")
                completion(nil)
                return
            }
            
            completion(location.coordinate)
        }
    }
}
