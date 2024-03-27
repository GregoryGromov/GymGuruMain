//
//  DurationChartViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.02.2024.
//

import SwiftUI
import Combine

class DurationChartViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published var countOfElements = 0
    @Published var trainings = [Training]()
    
    init() {
        cancellable = TrainingsStatisticsService.shared.$trainingsOfTheRange.sink { [weak self] trainings in
            self?.trainings = trainings
        }
    }
}
