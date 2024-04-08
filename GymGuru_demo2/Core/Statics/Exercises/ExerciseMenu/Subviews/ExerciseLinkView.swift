//
//  ExerciseLinkView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import SwiftUI
import Charts

struct ExerciseLinkView: View {
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.6), Color.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    let chartInfo: ChartExerciseInfo
    let points: [WeightDateItem]
    
    init(chartInfo: ChartExerciseInfo) {
        self.chartInfo = chartInfo
        self.points = chartInfo.points.filter {abs($0.date.timeIntervalSince(Date())) < Double(2_600_000)}
        
        
        
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(chartInfo.exerciseName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.leading, 16)
                    Spacer()
                }
                
            }
            .frame(width: 150)
            
            ChartExerciseSmall(points: points)
            
            Spacer()
            
            if let lastValue = points.last {
                if let firstValue = points.first {
                    HStack {
                        Spacer()
                        VStack {
                            Text("\(lastValue.maxWeight)kg")
                                .font(.headline)
                            
                            if lastValue.maxWeight - firstValue.maxWeight > 0 {
                                Text("+\(lastValue.maxWeight - firstValue.maxWeight)kg")
                                    .opacity(0.5)
                                    .font(.caption)
                            } else {
                                Text("\(lastValue.maxWeight - firstValue.maxWeight)kg")
                                    .opacity(0.5)
                                    .font(.caption)
                            }
                            
                        
                        }
                        
                        .fontWeight(.semibold)
                    }
                    .frame(width: 90)
                    
                }
            }
        }
//        .padding(.horizontal, 12)
        .padding(.vertical, 9)
    }
}


