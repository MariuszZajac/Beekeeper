//
//  SetApiaryViewModel.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 18/08/2023.
//

import Foundation
import CoreLocation

class SetApiaryViewModel: ObservableObject {
    @Published var apiaryName = ""
    @Published var apiaryOwner = ""
    @Published var selectedLocation: ApiaryLocation?
    @Published var address = ""
    @Published var apiary = [Apiary]()
    
    init() {
        loadApiaries()
    }

    func loadApiaries() {
        apiary = Apiary.loadApiaries()
    }


    enum ApiaryError: Error {
        case noSelectedLocation
    }
    

    func createApiary() throws -> Apiary {
        guard let selectedLocation = selectedLocation else {
            throw ApiaryError.noSelectedLocation
        }
        
        let newApiary = Apiary(id: UUID(), apiaryName: apiaryName, apiaryLocation: selectedLocation, apiaryOwner: apiaryOwner)
           apiary.append(newApiary)
        Apiary.saveApiaries(apiary)

        return newApiary
    }
}
