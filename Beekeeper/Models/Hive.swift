//
//  Hive.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import Foundation

struct Hive: Identifiable {
    
    let id: UUID
    let hiveNumber: Int
    let hiveProducent: HiveProducent
    let hiveSize: [Int]  //TODO: gniazdo" (nest), "korpus" (body), or "miodnia" (honey super) możliwość dodawania kolejnych poziomów.
    let hiveLastInspection: Date
    let hiveInspection: [Date] //TODO: = [hiveLastInspection] .list
  
    
    
    
    
}

enum HiveProducent: String {
    case Langstroth = "Langstroth"
    case Dadant = "Dadant"
    case Wielkopolski = "Wielkopolski"
    case Warszawski = "Warszawski"
    case Wielkopolski18 = "Wielkopolski 18"
    case Ostrowskiej = "Ostrowskiej"

}
