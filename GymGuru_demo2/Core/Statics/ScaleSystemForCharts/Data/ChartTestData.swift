//
//  ChartTestData.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 07.04.2024.
//

import Foundation

struct ChartItem: Identifiable {
    let id = UUID().uuidString
    
    let value: Int
    let date: Date
}


class ChartTestData {
    var chartItems = [
        ChartItem(value: 100, date: Date()),
        ChartItem(value: 85, date: Date.now.addingTimeInterval(-86400)),
        ChartItem(value: 70, date: Date.now.addingTimeInterval(-864000)),
        ChartItem(value: 80, date: Date.now.addingTimeInterval(-2064000)),
        ChartItem(value: 75, date: Date.now.addingTimeInterval(-3024000)),
        ChartItem(value: 63, date: Date.now.addingTimeInterval(-3924000)),
        ChartItem(value: 55, date: Date.now.addingTimeInterval(-8640000)),
    ]
}
