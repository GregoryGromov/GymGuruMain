//
//  TrainingStatisticViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 15.02.2024.
//

import Foundation

class TrainingListViewModel: ObservableObject {
    
    @Published var trainings: [Training]
    
    init() {
        //self.trainings = CoreDataManager.shared.getTrainings()
        self.trainings = DataMOCK().TrainingsMOCK
    }
}
