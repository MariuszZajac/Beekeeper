//
//  Colony.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import Foundation

struct Colony: Identifiable, Codable {
    var id: UUID = UUID()
    let health: HealthStatus
    let condition: ColonyCondition
    var structure: ColonyStructure
    let isMature: Bool // odkład czy stary ul.
    let queen: Queen?
    let hive: Hive
}


enum HealthStatus: String, Codable {
    case excellent
    case good
    case average
    case poor
}

enum ColonyCondition: String, Codable {
    case active
    case dormant
    case expanding
    case declining
}

struct ColonyStructure: Codable {
    var broodPercentage: Double
    var honeyPercentage: Double
    var larvaePercentage: Double
    var pollenPercentage: Double
    
  
    init(broodPercentage: Double = 0, honeyPercentage: Double = 0, larvaePercentage: Double = 0, pollenPercentage: Double = 0) {
        self.broodPercentage = broodPercentage
        self.honeyPercentage = honeyPercentage
        self.larvaePercentage = larvaePercentage
        self.pollenPercentage = pollenPercentage
    }
    
    // Funkcja zwracająca procentowy udział każdego składnika w ulu
    func componentParticipation() -> [String: Double] {
        let total = broodPercentage + honeyPercentage + larvaePercentage + pollenPercentage
        guard total != 0 else { return ["Brood": 0, "Honey": 0, "Larvae": 0, "Pollen": 0] } // Aby uniknąć dzielenia przez zero
        
        return [
            "Brood": broodPercentage / total * 100,
            "Honey": honeyPercentage / total * 100,
            "Larvae": larvaePercentage / total * 100,
            "Pollen": pollenPercentage / total * 100
        ]
    }
    
    // Funkcja sprawdzająca, czy suma procentów nie przekracza 100%
    func isTotalValid() -> Bool {
        return broodPercentage + honeyPercentage + larvaePercentage + pollenPercentage <= 100.0
    }
}

extension Colony {
    private static let userDefaultsKey = "StoredColonies"
    private static let defaultsManager = UserDefaultsManager()

    static func saveColonies(_ colonies: [Colony]) {
        defaultsManager.save(colonies, forKey: userDefaultsKey)
    }
    
    
    static func loadColonies() -> [Colony] {
        return defaultsManager.load([Colony].self, forKey: userDefaultsKey) ?? []
    }
}
