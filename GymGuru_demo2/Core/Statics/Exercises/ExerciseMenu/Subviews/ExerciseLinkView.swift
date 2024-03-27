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
            .frame(width: 180)
            
            ChartExerciseSmall(points: chartInfo.points)
            
            Spacer()
            
            if let lastValue = chartInfo.points.last {
                if let firstValue = chartInfo.points.first {
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
                        .padding(.trailing, 6)
                        .fontWeight(.semibold)
                    }
                    .frame(width: 90)
                    
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
    }
}


