//
//  Queen.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Queen: Identifiable {
    let id: UUID
    let race: BeeRace
    let number: Int?
    let isInseminated: Bool
    let dateAddedToHive: Date?
    let quality: QueenQuality
}

struct BeeRace {
    static let Buckfast = BeeRace(name: "Buckfast")
    static let Krainka = BeeRace(name: "Krainka")
    static let other = BeeRace(name: "Other")
    
    let name: String
}

enum QueenQuality: String {
    case poor
    case normal
    case excellent
}

extension BeeRace {
    private static let userDefaultsKey = "CustomBeeRaces"
    
    // Zapisuje listę ras pszczół
    static func saveRaces(_ races: [BeeRace]) {
        let raceNames = races.map { $0.name }
        UserDefaults.standard.set(raceNames, forKey: userDefaultsKey)
    }
    
    // Odczytuje listę ras pszczół
    static func loadRaces() -> [BeeRace] {
        if let raceNames = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            return raceNames.map { BeeRace(name: $0) }
        }
        return []
    }
}
