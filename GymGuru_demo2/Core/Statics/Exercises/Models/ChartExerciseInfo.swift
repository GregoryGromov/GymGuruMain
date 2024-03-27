//
//  WeightDateItem.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import Foundation

struct ChartExerciseInfo: Identifiable {
    let id = UUID().uuidString
    
    let exerciseName: String
    let points: [WeightDateItem]
}




