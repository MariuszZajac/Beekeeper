//
//  CRUDOperations.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 21/08/2023.
//

import Foundation

// Uniwersalny protokół CRUD
protocol CRUDOperations {
    associatedtype ItemType: Identifiable
    
    mutating func add(_ item: ItemType)
    mutating func remove(itemWithID id: ItemType.ID) -> ItemType?
    func get(itemWithID id: ItemType.ID) -> ItemType?
    mutating func update(item: ItemType) -> Bool
}
