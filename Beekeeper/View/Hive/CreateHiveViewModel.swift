//
//  CreateHiveViewModel.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 25/08/2023.
//

import Foundation
class CreateHiveViewModel: ObservableObject {
    @Published var hiveNumber: Int = 0
    @Published var selectedProducent: HiveProducent = .wielkopolski18
    @Published var hiveSections: [HiveSection: Int] = [
        .nest: 1,
        .body: 0,
        .honeySuper: 0,
        .feeder: 0
    ]
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    func getHiveSections() -> [HiveSection] {
        var hiveSectionsArray: [HiveSection] = []
        for (section, count) in hiveSections {
            hiveSectionsArray += Array(repeating: section, count: count)
        }
        return hiveSectionsArray
    }
    fileprivate func showMassageForResult(_ saveResult: Bool) {
        if saveResult {
            alertMessage = "Ul został pomyślnie utworzony."
        } else {
            alertMessage = "Wystąpił błąd podczas tworzenia ula."
        }
    }
    
    func createHive() {
        let hiveSectionsArray = getHiveSections()
        
        let hive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
        
        // Zapisz ul
        let saveResult = Hive.saveHives([hive])
        showMassageForResult(saveResult)
        showingAlert = true
    }
    
    
    func editHive(with hiveNumber: Int) {
        if let index = Hive.loadHives().firstIndex(where: { $0.hiveNumber == hiveNumber }) {
            let hiveSectionsArray = getHiveSections()
            let updatedHive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
            
            // Wczytaj wszystkie ule, zastąp ul, który chcesz zaktualizować, i zapisz zmiany
            var existingHives = Hive.loadHives()
            existingHives[index] = updatedHive
            let saveResult = Hive.saveHives(existingHives)
            
            showMassageForResult(saveResult)
        } else {
            print("Ul o numerze \(hiveNumber) nie został znaleziony.")
        }
    }
    
}
