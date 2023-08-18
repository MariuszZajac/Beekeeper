//
//  SetApiaryViewModel.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 18/08/2023.
//

import Foundation

class SetApiaryViewModel: ObservableObject {
    @Published var apiaryName = ""
    @Published var apiaryOwner = ""
    @Published var selectedLocation: ApiaryLocation?
    @Published var address = "" 
    
    func createApiary() -> Apiary? {
        guard let selectedLocation = selectedLocation else {
            return nil
        }
        
        return Apiary(id: UUID(), apiaryName: apiaryName, apiaryLocation: selectedLocation, apiaryOwner: apiaryOwner)
    }
}

