//
//  TonnageChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import SwiftUI
import Charts

struct TonnageChart: View {
    
    @StateObject var viewModel = TonnageChartViewModel()
   
    

    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray5))

            VStack {
//                HStack {
//                    Text("Average workout tonnage is ") +
//                    Text("\(viewModel.averageTonnage) kg")
//                        .bold()
//                    Spacer()
//                }
                Chart {
                    ForEach(viewModel.trainings, id: \.self) { training in
                        BarMark(
                            x: .value("ID", training.id),
                            y: .value("Tonnage", training.tonnage)
                        )
                        .foregroundStyle(.orange)
                    }
                }
                .chartXAxis(.hidden)
            }
            .padding()
        }
        .frame(width: 380, height: 300)
        .padding(.top)
        .padding(.horizontal)
    }
    
    
}

