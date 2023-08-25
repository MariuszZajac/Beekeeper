//
//  CreateHiveView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 24/08/2023.
//

import SwiftUI

struct CreateHiveView: View {
    @State var hiveNumber: Int
    @State var selectedProducent: HiveProducent
    @State private var hiveSections: [HiveSection: Int] = [
        .nest: 1,
        .body: 0,
        .honeySuper: 0,
        .feeder: 0
    ]
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 5) {
            TextField("Numer ula", value: $hiveNumber, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 180)
            
            Picker("Wybierz Producenta", selection: $selectedProducent) {
                ForEach(HiveProducent.allCases, id: \.self) { producent in
                    Text(producent.rawValue).tag(producent)
                }
            }
            VStack(alignment: .leading,spacing: 5) {
                Text("Skład ula:")
                    .font(.title3)
                    .bold()
                
                
                ForEach(HiveSection.allCases, id: \.self) { section in
                    HStack(spacing: 5) {
                        Text(section.description)
                            .frame(width: 120, alignment: .leading)
                            .padding(.trailing, 50)
                        
                        Button(action: {
                            if section == .nest {
                                if hiveSections[section, default: 0] > 1 {
                                    hiveSections[section, default: 0] -= 1
                                }
                            } else if hiveSections[section, default: 0] > 0 {
                                hiveSections[section, default: 0] -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle")
                            .foregroundColor(.red)                        }
                        Text("\(hiveSections[section, default: 0])")
                            .bold()
                        Button(action: {
                            hiveSections[section, default: 0] += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            Button("Utwórz ul", action: createHive)
                .buttonStyle(FilledRoundedCornerButtonStyle())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
        
    }
    
    
    
    
    func getHiveSectionsArray() -> [HiveSection] {
        var hiveSectionsArray: [HiveSection] = []
        for (section, count) in hiveSections {
            hiveSectionsArray += Array(repeating: section, count: count)
        }
        return hiveSectionsArray
    }
    func createHive() {
        let hiveSectionsArray = getHiveSectionsArray()
        
        let hive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
        
        // Zapisz ul
        let saveResult = Hive.saveHives([hive])
        
        if saveResult {
            alertMessage = "Ul został pomyślnie utworzony."
        } else {
            alertMessage = "Wystąpił błąd podczas tworzenia ula."
        }
        showingAlert = true
    }
    
    
    func editHive(with hiveNumber: Int) {
        if let index = Hive.loadHives().firstIndex(where: { $0.hiveNumber == hiveNumber }) {
            let hiveSectionsArray = getHiveSectionsArray()
            let updatedHive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
            
            // Wczytaj wszystkie ule, zastąp ul, który chcesz zaktualizować, i zapisz zmiany
            var existingHives = Hive.loadHives()
            existingHives[index] = updatedHive
            let saveResult = Hive.saveHives(existingHives)
            
            if saveResult {
                alertMessage = "Ul został pomyślnie zaktualizowany."
            } else {
                alertMessage = "Wystąpił błąd podczas aktualizacji ula."
            }
            showingAlert = true
        } else {
            print("Ul o numerze \(hiveNumber) nie został znaleziony.")
        }
    }
    
    struct CreateHiveView_Previews: PreviewProvider {
        static var previews: some View {
            CreateHiveView(hiveNumber: 1, selectedProducent: .langstroth)
        }
    }
    
}
