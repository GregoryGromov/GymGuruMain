//
//  ChartExerciseSmall.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import SwiftUI
import Charts

struct ChartExerciseSmall: View {
    
    let points: [WeightDateItem]
    
    var body: some View {
        Chart {
            ForEach(points) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("MaxWeight", point.maxWeight)
                )
            }
            
            ForEach(points) { point in
                AreaMark(
                    x: .value("Date", point.date),
                    y: .value("MaxWeight", point.maxWeight)
                )
            }
            .foregroundStyle(Colors.shared.linearGradientBlue)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(width: 70, height: 40)
    }
}


