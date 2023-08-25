//
//  UserDefaultsManager.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 22/08/2023.
//
import Foundation
class UserDefaultsManager {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // Zapisuje dowolny obiekt kodowalny do UserDefaults
    func save<T: Encodable>(_ object: T, forKey key: String) -> Bool {
        do {
            let encodedData = try JSONEncoder().encode(object)
            userDefaults.set(encodedData, forKey: key)
            return true
        } catch {
            print("Błąd podczas zapisywania obiektu: \(error.localizedDescription)")
            return false
        }
    }


    // Wczytuje obiekt z UserDefaults
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let savedData = userDefaults.data(forKey: key) else { return nil }
        do {
            let object = try JSONDecoder().decode(type, from: savedData)
            return object
        } catch {
            print("Błąd podczas wczytywania obiektu: \(error.localizedDescription)")
            return nil
        }
    }
}
