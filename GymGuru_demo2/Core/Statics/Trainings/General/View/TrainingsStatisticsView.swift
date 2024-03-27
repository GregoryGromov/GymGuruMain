//
//  TrainingsStatisticsView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.02.2024.
//

import SwiftUI

struct TrainingsStatisticsView: View {
    
    //@StateObject var viewModel = TrainingsStatisticsViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("5") {
                    withAnimation {
                        TrainingsStatisticsService.shared.countOfBars = 5
                    }
                    
                }
                Button("10") {
                    withAnimation {
                        TrainingsStatisticsService.shared.countOfBars = 10
                    }
                }
            }
            
            
            TonnageChart()
            DurationChart()
        }
    }
}

