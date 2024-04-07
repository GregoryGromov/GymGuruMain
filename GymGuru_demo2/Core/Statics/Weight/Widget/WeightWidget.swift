//
//  WeightWidget.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 18.03.2024.
//
//
//  WeightStatisticsView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 18.03.2024.
//

import SwiftUI
import Charts

struct WeightWidget: View {
    
    var weightItems = WeightMOCK.shared.items
    
    //let weightItems = CoreDataManager.shared.getWeightNotes()
    
    var minWeight: Float {
        
        var minWeight = weightItems[0].weight
        
        for weightItem in weightItems {
            if weightItem.weight < minWeight {
                minWeight = weightItem.weight
            }
        }
        
        return minWeight
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
            Chart {
                ForEach(weightItems) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("MaxWeight", point.weight - minWeight)
                    )
                }
                .foregroundStyle(.orange)
                .lineStyle(StrokeStyle(lineWidth: 5))
                .interpolationMethod(.cardinal)
              
                
                ForEach(weightItems) { point in
                    AreaMark(
                        x: .value("Date", point.date),
                        y: .value("MaxWeight", point.weight - minWeight)
                    )
                }
                .foregroundStyle(Colors.shared.linearGradientOrange)
                .interpolationMethod(.cardinal)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(width: 130, height: 130)
            .chartYAxis {
                //AxisMarks(values: [minWeight, ])
            }
            
            Text("68.4")
                .font(.title)
                .fontWeight(.bold)
                .offset(x: -38, y: -50)
        }
        .frame(width: 180, height: 180)
        
    }
}



#Preview {
    WeightWidget()
        .preferredColorScheme(.dark)
}
