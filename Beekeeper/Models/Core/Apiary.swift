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

struct ApiaryManager: CRUDOperations {
    typealias ItemType = Apiary
    
    private var apiaries: [Apiary] = Apiary.loadApiaries()
    
    mutating func add(_ item: Apiary) {
        apiaries.append(item)
    }
    
    mutating func remove(itemWithID id: Apiary.ID) -> Apiary? {
        if let index = apiaries.firstIndex(where: { $0.id == id }) {
            let removedItem = apiaries.remove(at: index)
            Apiary.saveApiaries(apiaries) // zapisz zmiany
            return removedItem
        }
        return nil
    }

    
    func get(itemWithID id: Apiary.ID) -> Apiary? {
        return apiaries.first(where: { $0.id == id })
    }
    
    mutating func update(item: Apiary) -> Bool {
        if let index = apiaries.firstIndex(where: { $0.id == item.id }) {
            apiaries[index] = item
            return true
        }
        return false
    }
}
