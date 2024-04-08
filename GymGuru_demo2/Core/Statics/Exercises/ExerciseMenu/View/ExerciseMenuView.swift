//
//  ExerciseMenuView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import SwiftUI
import Charts

struct ExerciseMenuView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var service: ExerciseStatisticsService
    
    @State private var searchText = ""
    
    init(service: ExerciseStatisticsService) {
        self.service = service
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return service.exerciseNames
        } else {
            return service.exerciseNames.filter { $0.contains(searchText) }
        }
    }
    
    
    var body: some View {
        VStack {
            
            
            NavigationStack {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink {
                            ExerciseStatisticsView(chartInfo: service.findExerciseInfo(byName: name))
                        } label: {
                            ExerciseLinkView(chartInfo: service.findExerciseInfo(byName: name))
                                .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle("Упражнения")
            }
            .searchable(text: $searchText)
            
            Text("Список всех тренировок")
            Button("Закрыть") {
                dismiss()
            }
        }
    }
}
