//
//  Queen.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation
struct Queen: Identifiable{
    let id: UUID
    
    let queenRace:QueenRace?
    let queenNumber: Int?
    let queenIsInseminated: Bool
    let queenDateAddToHive: Date?
    let queenQuality:QueenQuality
    
    
}

enum QueenRace {
    case Buckfust
    case Krainka
    case inna // fajnie by było móc dodać swoją nazwę. 
}
enum QueenQuality {
    case poor
    case normal
    case excellent
}
