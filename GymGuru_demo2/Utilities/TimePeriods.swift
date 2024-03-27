//
//  TimePeriods.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import Foundation

class TimePeriods {
    static let week1 = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    static let week2 = Calendar.current.date(byAdding: .day, value: -14, to: Date())!
    
    static let month1 = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    static let month2 = Calendar.current.date(byAdding: .day, value: -60, to: Date())!
    static let month3 = Calendar.current.date(byAdding: .day, value: -90, to: Date())!
    static let month6 = Calendar.current.date(byAdding: .day, value: -180, to: Date())!
    
    static let year1 = Calendar.current.date(byAdding: .day, value: -365, to: Date())!
}





