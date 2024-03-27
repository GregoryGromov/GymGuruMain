//
//  DurationChart.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.02.2024.
//

import SwiftUI
import Charts

struct DurationChart: View {
    @StateObject var viewModel = TonnageChartViewModel()
   
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray5))

            VStack {

                Chart {
                    ForEach(viewModel.trainings, id: \.self) { training in
                        BarMark(
                            x: .value("ID", training.id),
                            y: .value("Duration", training.duration)
                        )
                        .foregroundStyle(.cyan)
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

