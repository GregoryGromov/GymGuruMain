//
//  WeightMOCK.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 18.03.2024.
//

import Foundation

class WeightMOCK {
    
    static let shared = WeightMOCK()
        
    let items = [
        WeightNote(id: UUID().uuidString, weight: 70.4, date: Date.now.addingTimeInterval(-200000)),
        WeightNote(id: UUID().uuidString, weight: 69.8, date: Date.now.addingTimeInterval(-300000)),
        WeightNote(id: UUID().uuidString, weight: 69.1, date: Date.now.addingTimeInterval(-400000)),
        WeightNote(id: UUID().uuidString, weight: 68.4, date: Date.now.addingTimeInterval(-700000)),
        WeightNote(id: UUID().uuidString, weight: 66.8, date: Date.now.addingTimeInterval(-900000)),
        WeightNote(id: UUID().uuidString, weight: 66.5, date: Date.now.addingTimeInterval(-1300000)),
        WeightNote(id: UUID().uuidString, weight: 66.9, date: Date.now.addingTimeInterval(-1700000)),
        WeightNote(id: UUID().uuidString, weight: 64.7, date: Date.now.addingTimeInterval(-2200000))
    ]
}
