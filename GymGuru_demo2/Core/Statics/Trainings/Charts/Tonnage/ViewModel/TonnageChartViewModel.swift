//
//  TonnageChartViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 15.02.2024.
//

import Foundation
import Combine

class TonnageChartViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published var countOfElements = 0
    @Published var trainings = [Training]()
    
    init() {
        cancellable = TrainingsStatisticsService.shared.$trainingsOfTheRange.sink { [weak self] trainings in
            self?.trainings = trainings
        }
    }
    
//    let parentViewModel: TrainingsStatisticsViewModel
//    
//    init(parentViewModel: TrainingsStatisticsViewModel) {
//        self.parentViewModel = parentViewModel
//    }
    
//    var averageTonnage: Int {
//        var sumTonnage = 0
//        for training in parentViewModel.allTrainings.suffix(parentViewModel.countOfBars) {
//            sumTonnage += calculateTrainingTonnage(training: training)
//        }
//        
//        return Int(sumTonnage / parentViewModel.countOfBars)
//    }
    
//    func calculateTrainingTonnage(training: Training) -> Int {
//        var tonnage = 0
//        
//        for exercise in training.exercises {
//            for set in exercise.sets {
//                tonnage += Int(Float(set.amount) * set.weight)
//            }
//        }
//        return tonnage
//    }
}
