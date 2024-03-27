//
//  WeightDateItem.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import Foundation

struct WeightDateItem: Identifiable {
    let id = UUID().uuidString
    
    let date: Date
    let maxWeight: Int
}
