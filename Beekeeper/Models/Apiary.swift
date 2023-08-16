//
//  Apiary.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Apiary: Identifiable {
    let id: UUID
    let apiaryName: String
    let apiaryLocation: String // do pogody nie wiem czy gps dane nie potrzebne. 
    let apiaryOwner: String

    
}
