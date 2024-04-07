//
//  ScaleSystemView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 07.04.2024.
//

import SwiftUI
import Charts

struct ScaleSystemView: View {
    
    @StateObject var viewModel = ScaleSystemViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.availableTimePeriods, id: \.self) { timePeriod in
                    Button {
                        withAnimation {
                            viewModel.computeChartItems(selectedPeriod: timePeriod)
                        }
                    } label: {
                        Text(timePeriod.name)
                    }
                }
                
                Button {
                    withAnimation {
                        viewModel.showAllChartItems()
                    }
                } label: {
                    Text("all")
                }
                
            }
            Chart {
                ForEach(viewModel.chartItemsPerSelectedPeriod) { chartItem in
                    LineMark(
                        x: .value("Date", chartItem.date),
                        y: .value("Value", chartItem.value)
                    )
                }
            }
            .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    ScaleSystemView()
}
