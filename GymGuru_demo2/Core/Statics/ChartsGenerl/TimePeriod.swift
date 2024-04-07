//
//  TimePeriod.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 07.04.2024.
//

import Foundation

struct TimePeriod: Identifiable, Hashable {
    let id = UUID().uuidString
    let seconds: Int
    let name: String
    
    static let values = [
        TimePeriod(seconds: 1_209_600, name: "week2"),
        TimePeriod(seconds: 2_592_000, name: "month1"),
        TimePeriod(seconds: 7_776_000, name: "month3"),
        TimePeriod(seconds: 15_724_800, name: "month6"),
        TimePeriod(seconds: 31_536_000, name: "year1"),
        TimePeriod(seconds: 63_072_000, name: "year2")
    ]
}
