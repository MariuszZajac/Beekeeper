//
//  Hive.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Hive: Identifiable, Codable {
    
    let id: UUID
    let hiveNumber: Int
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

enum HiveProducent: String, Codable {
    case langstroth = "Langstroth"
    case dadant = "Dadant"
    case wielkopolski = "Wielkopolski"
    case warszawski = "Warszawski"
    case wielkopolski18 = "Wielkopolski 18"
    case ostrowskiej = "Ostrowskiej"
}

enum HiveSection: Codable {
    case nest
    case body
    case honeySuper
}
