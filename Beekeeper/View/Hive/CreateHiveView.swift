//
//  CreateHiveView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 24/08/2023.
//

import SwiftUI

struct CreateHiveView: View {
    @ObservedObject var viewModel = CreateHiveViewModel()
    
    var body: some View {
        VStack(spacing: 5) {
            TextField("Numer ula", value: $viewModel.hiveNumber, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 180)
            
            Picker("Wybierz Producenta", selection: $viewModel.selectedProducent) {
                ForEach(HiveProducent.allCases, id: \.self) { producent in
                    Text(producent.rawValue).tag(producent)
                }
            }
            VStack(alignment: .leading, spacing: 5) {
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
                                if viewModel.hiveSections[section, default: 0] > 1 {
                                    viewModel.hiveSections[section, default: 0] -= 1
                                }
                            } else if viewModel.hiveSections[section, default: 0] > 0 {
                                viewModel.hiveSections[section, default: 0] -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                        Text("\(viewModel.hiveSections[section, default: 0])")
                            .bold()
                        Button(action: {
                            viewModel.hiveSections[section, default: 0] += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            Button("Utwórz ul", action: viewModel.createHive)
                .buttonStyle(FilledRoundedCornerButtonStyle())
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
        }
    }
    
    struct CreateHiveView_Previews: PreviewProvider {
        static var previews: some View {
            CreateHiveView()
        }
    }
}
