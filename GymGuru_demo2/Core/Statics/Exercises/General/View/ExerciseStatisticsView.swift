//
//  ExerciseStatisticsView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import SwiftUI
import Charts

enum ChartPeriod: String {
    case week2 = "W2"
    case month1 = "M1"
    case month3 = "M3"
    case month6 = "W6"
    case year1 = "Y1"
    case all = "All"
}



struct ExerciseStatisticsView: View {
    
    
    @StateObject var viewModel: ExerciseStaticticsViewModel
    @State var pointsPerSelectedPeriod: [WeightDateItem]
    
    @State var chartPeriod: ChartPeriod = .month1
    
    
    @State var weightDifference: Int = 0
    
    init(chartInfo: ChartExerciseInfo) {
        self._viewModel = StateObject(wrappedValue: ExerciseStaticticsViewModel(chartInfo: chartInfo))
        let selectedPoints = chartInfo.points.filter { $0.date >= TimePeriods.month1 }
        self.pointsPerSelectedPeriod = selectedPoints
    } 
    
    let period = ChartPeriod.month1
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.chartInfo.exerciseName)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("ГРУДЬ · ПЛЕЧИ")
                        .opacity(0.6)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .padding(.leading, 20)
                
                Spacer()
                
                if let lastPoint = pointsPerSelectedPeriod.last {
                    if let firstPoint = pointsPerSelectedPeriod.first {
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("\(lastPoint.maxWeight) kg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                if weightDifference >= 0 {
                                    Text("+\(weightDifference)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.green)
                                        .frame(width: 50)
                                } else if weightDifference < 0 {
                                    Text("\(weightDifference)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.red)
                                        .frame(width: 50)
                                }
                                
                            }
                            
                           
                                switch chartPeriod {
                                case .month1:
                                    Text("Последний месяц")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                case .month3:
                                    Text("Последние 3 месяца")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                case .month6:
                                    Text("Последние полгода")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                case .week2:
                                    Text("Последние 2 недели")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                case .year1:
                                    Text("Последний год")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                case .all:
                                    Text("Всё время")
                                        .opacity(0.6)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                }
                            
                            
                                
                                
                            
                                
                            
                            
                        }
                        .padding(.trailing, 20)
                    }
                }
                
            }
            
            
            
            HStack {
                ForEach(viewModel.scaleOptions) { option in
                    Button {
                        withAnimation {
                            pointsPerSelectedPeriod = viewModel.chartInfo.points.filter { $0.date >= option.date }
                            chartPeriod = option.name
                            computeWeightDifference()
                        }
                       
                    } label: {
                        if chartPeriod == option.name {
                            Text(option.name.rawValue)
                                .fontWeight(.bold)
                        } else {
                            Text(option.name.rawValue)
                        }
                        
                    }
                }
                
                Button {
                    withAnimation {
                        pointsPerSelectedPeriod = viewModel.chartInfo.points
                        chartPeriod = .all
                        computeWeightDifference()
                    }
                } label: {
                    if chartPeriod == .all {
                        Text("All")
                            .fontWeight(.bold)
                    } else {
                        Text("All")
                    }
                    
                }
            }
            
            
    
            
            Chart {
                ForEach(pointsPerSelectedPeriod) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("MaxWeight", point.maxWeight)
                    )
                }
                
                ForEach(pointsPerSelectedPeriod) { point in
                    AreaMark(
                        x: .value("Date", point.date),
                        y: .value("MaxWeight", point.maxWeight)
                    )
                }
                .foregroundStyle(Colors.shared.linearGradientBlue)
                
                
   
            }
            .frame(width: 380, height: 380)
            
            
        }
        .onAppear {
            computeWeightDifference()
        }
        
    }
    
    func computeWeightDifference() {
        if let lastPoint = pointsPerSelectedPeriod.last {
            if let firstPoint = pointsPerSelectedPeriod.first {
                let difference = lastPoint.maxWeight - firstPoint.maxWeight
                self.weightDifference = difference
            }
        }
    }
}



