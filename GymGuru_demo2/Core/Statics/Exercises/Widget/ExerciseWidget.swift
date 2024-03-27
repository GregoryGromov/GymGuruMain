//
//  ExerciseWidget.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import SwiftUI
import Charts


struct ExerciseWidget: View {
    
    @ObservedObject var service: ExerciseStatisticsService
    
    init(service: ExerciseStatisticsService) {
        self.service = service
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
            VStack {
                ForEach(service.chartInfo.prefix(3)) { info in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(info.exerciseName)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 4)
                                Spacer()
                            }
                            
                        }
                        .frame(width: 160)
                        
                       
                        ChartExerciseSmall(points: info.points)
                        
                        
                        Spacer()
                        
                        
                        
                        if let lastValue = info.points.last {
                            if let firstValue = info.points.first {
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

                
                
                

                    
                
                    
//                    .padding(.top, 8)
//                    .padding(.bottom, 8)
                }
                    

                
            }
        .frame(width: 380, height: 200)
        .padding(.top)
        .padding(.horizontal, 3)
        }
}


