//
//  Hive.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Hive: Identifiable, Codable {
    
    let id: UUID
    let hiveNumber: Int?
    
    let hiveProducent: HiveProducent
    let hiveSections: [HiveSection]
    var hiveInspections: [Inspection]
    var hiveLastInspection: Date? {
           return hiveInspections.sorted(by: { $0.lastInspection > $1.lastInspection }).first?.lastInspection
       }
    
    
    init(hiveNumber: Int, hiveProducent: HiveProducent, hiveSections: [HiveSection], hiveLastInspection: Date = Date()) {
        self.id = UUID()
        self.hiveNumber = hiveNumber
        self.hiveProducent = hiveProducent
        self.hiveSections = hiveSections
        self.hiveInspections = []
    }
}

enum HiveProducent: String, Codable, CaseIterable {
    case langstroth = "Langstroth"
    case dadant = "Dadant"
    case wielkopolski = "Wielkopolski"
    case wielkopolski18 = "Wielkopolski 18cm"
    case warszawski = "Warszawski"
    case ostrowskiej = "Ostrowskiej"
    case inny = "Inny"
}

enum HiveSection: String, Codable, CaseIterable{
    case nest = "Gniazdo"
    case body = "Korpus"
    case honeySuper = "Miodnia"
    case feeder = "Podkarmiaczka"
    var description: String {
        switch self {
        case .nest:
            return "Gniazdo"
        case .body:
            return "Korpus"
        case .honeySuper:
            return "Miodnia"
        case .feeder:
            return "Podkarmiaczka"
        }
    }
}
extension Hive {
    private static let userDefaultsKey = "CustomHives"
    private static let defaultsManager = UserDefaultsManager()

    static func saveHives(_ hives: [Hive]) -> Bool {
        return defaultsManager.save(hives, forKey: userDefaultsKey)
    }

    static func loadHives() -> [Hive] {
        return defaultsManager.load([Hive].self, forKey: userDefaultsKey) ?? []
    }
}
