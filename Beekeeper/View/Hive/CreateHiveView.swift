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
                            if hiveSections[.nest] != nil && hiveSections[.nest]! > 1 {
                                hiveSections[.nest]! -= 1
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
            
            
            
        }
    }
    
    func createHive() {
        var hiveSectionsArray: [HiveSection] = []
        for (section, count) in hiveSections {
            hiveSectionsArray += Array(repeating: section, count: count)
        }
        
        let hive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
        
        // Zapisz ul
        var existingHives = Hive.loadHives()
        existingHives.append(hive)
        Hive.saveHives(existingHives)
        
    }
    
    func editHive(with hiveNumber: Int) {
        // Znajdź indeks ulu, który chcesz zaktualizować
        if let index = Hive.loadHives().firstIndex(where: { $0.hiveNumber == hiveNumber }) {
            var hiveSectionsArray: [HiveSection] = []
            for (section, count) in hiveSections {
                hiveSectionsArray += Array(repeating: section, count: count)
            }
            
            // Stworzenie nowego ulu z nowymi danymi
            let updatedHive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
            
            // Wczytaj wszystkie ule, zastąp ul, który chcesz zaktualizować, i zapisz zmiany
            var existingHives = Hive.loadHives()
            existingHives[index] = updatedHive
            Hive.saveHives(existingHives)
        } else {
            print("Ul o numerze \(hiveNumber) nie został znaleziony.")
        }
    }
}

struct CreateHiveView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHiveView(hiveNumber: 1, selectedProducent: .langstroth)
    }
}

