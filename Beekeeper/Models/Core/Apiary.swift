//
//  Apiary.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation
import MapKit


struct Apiary: Identifiable {
    let id: UUID
    let apiaryName: String
    var apiaryLocation: ApiaryLocation // do pogody gps dane potrzebne.
    let apiaryOwner: String
    
    
}
struct ApiaryLocation: Identifiable {
    var id: UUID
    
    var longitude: Double
    var latitude: Double
    var assigned: Bool = false 
}

