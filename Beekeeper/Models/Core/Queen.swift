//
//  Queen.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Queen: Identifiable, Codable {
    let id: UUID
    let race: BeeRace
    let number: Int?
    let isInseminated: Bool
    let dateAddedToHive: Date?
    let quality: QueenQuality
}

struct BeeRace: Codable {
    static let Buckfast = BeeRace(name: "Buckfast")
    static let Krainka = BeeRace(name: "Krainka")
    static let other = BeeRace(name: "Other")
    
    let name: String
}

enum QueenQuality: String, Codable {
    case poor
    case normal
    case excellent
}

extension BeeRace {
    private static let userDefaultsKey = "CustomBeeRaces"
    private static let defaultsManager = UserDefaultsManager()

    static func saveRaces(_ races: [BeeRace]) {
        let raceNames = races.map { $0.name }
        defaultsManager.save(raceNames, forKey: userDefaultsKey)
    }
    
    static func loadRaces() -> [BeeRace] {
        if let raceNames: [String] = defaultsManager.load([String].self, forKey: userDefaultsKey) {
            return raceNames.map { BeeRace(name: $0) }
        }
        return []
    }
}
extension Queen {
    private static let userDefaultsKey = "StoredQueens"
    private static let defaultsManager = UserDefaultsManager()

    // Zapisuje listę królowych
    static func saveQueens(_ queens: [Queen]) {
        defaultsManager.save(queens, forKey: userDefaultsKey)
    }
    
    // Odczytuje listę królowych
    static func loadQueens() -> [Queen] {
        return defaultsManager.load([Queen].self, forKey: userDefaultsKey) ?? []
    }
}
