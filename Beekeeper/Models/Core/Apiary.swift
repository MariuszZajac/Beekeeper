//
//  Apiary.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation
import MapKit


struct Apiary: Identifiable, Codable {
    let id: UUID
    let apiaryName: String
    var apiaryLocation: ApiaryLocation?// do pogody gps dane potrzebne.
    let apiaryOwner: String
    
    
}
struct ApiaryLocation: Identifiable, Codable, Hashable {
    var id: UUID
    
    var longitude: Double
    var latitude: Double
    var assigned: Bool = false 
}

extension Apiary {
    private static let userDefaultsKey = "CustomApiaries"
    private static let defaultsManager = UserDefaultsManager()

    static func saveApiaries(_ apiaries: [Apiary]) {
        defaultsManager.save(apiaries, forKey: userDefaultsKey)
    }
    
    static func loadApiaries() -> [Apiary] {
        return defaultsManager.load([Apiary].self, forKey: userDefaultsKey) ?? []
    }
}
