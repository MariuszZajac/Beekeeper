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
            Text("")
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
            Button(action: {
                createHive()
            }) {
                Text("Utwórz Ul")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                  
            }

        }
    }
    
    func createHive() {
        var hiveSectionsArray: [HiveSection] = []
        for (section, count) in hiveSections {
            hiveSectionsArray += Array(repeating: section, count: count)
        }
        
        let hive = Hive(hiveNumber: hiveNumber, hiveProducent: selectedProducent, hiveSections: hiveSectionsArray)
        // Tutaj możesz dodać logikę zapisu lub inny kod związany z utworzeniem ulu
        print(hive)
    }
}

struct CreateHiveView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHiveView(hiveNumber: 1, selectedProducent: .langstroth)
    }
}

