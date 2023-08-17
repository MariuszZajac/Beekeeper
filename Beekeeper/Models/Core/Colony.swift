//
//  Colony.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import Foundation
struct Colony: Identifiable {
    var id: Int
    
    let health: String
    let condition: String
    var colonyStructure: ColonyStructure
    let isProductivity: Bool // dorosły ul czy odkład

}

struct ColonyStructure {
    // dodać najfajniej by było suwak z % jaki jest stan ula.
    // ile czerw, miód, larwy, pierzga zajmuje co zostanie przypisać do puste miejsce. 
}
