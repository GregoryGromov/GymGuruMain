//
//  TrainingStatisticView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 15.02.2024.
//

import SwiftUI

struct TrainingListView: View {
    
    @StateObject var viewModel = TrainingListViewModel()
    
    var body: some View {
        NavigationStack {
            
            
            TrainingsStatisticsView()
            
            ForEach(viewModel.trainings) { training in
                NavigationLink {
                    Text(training.id)
                } label: {
                    HStack {
                        Text("\(training.date)")
                        Spacer()
                        Text("Подробнее")
                    }
                    .padding()
                }
            }
        }
    }
}


