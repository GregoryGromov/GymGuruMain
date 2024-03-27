//
//  RouterViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 09.02.2024.
//

import Foundation
import SwiftUI


class RouterViewModel: ObservableObject {

    init() {
        detectState()
    }
    
    @Published var trainingInProgress = false
    
    @Published var program: Program? = nil
    
    func startTraining() {
        self.trainingInProgress = true
    }

    
    func finishTraining() {
        TrainingService.shared.setTrainingInProgressToFalse()
        detectState()
    }
    
    func setTrainingInProgress() {
        TrainingService.shared.setTrainingInProgressToTrue()
    }
    

    
    private func detectState() {
        let inProgress = TrainingService.shared.isTrainingInProgress()
        
        if inProgress {
            self.trainingInProgress = true
        } else {
            self.trainingInProgress = false
        }
    }
}
