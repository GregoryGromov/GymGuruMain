//
//  Training.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation

struct Training: Identifiable, Codable, Hashable {
    
    let id: String
    var date = Date()
    var dateEnd: Date?
    var exercises: [Exercise]
    
    var duration: Int {
        if let dateEnd = dateEnd {
            return Int(dateEnd.timeIntervalSince(date))
        } else {
            return 0
        }
    }
    
    var tonnage: Int {
        var totalTonnage = 0
        
        for exercise in exercises {
            for set in exercise.sets {
                totalTonnage += Int(Float(set.amount) * set.weight)
            }
        }
        return totalTonnage
    }
}




