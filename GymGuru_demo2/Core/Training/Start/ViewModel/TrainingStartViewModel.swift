//
//  TrainingRouter.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import Foundation
import SwiftUI

class TrainingStartViewModel: ObservableObject {
    
    @Published var programs: [Program]
    
    @Published var showAddProgramView = false
    
    @Published var selectedProgramId = ""
    
    static func getPrograms() -> [Program] {
        return CoreDataManager.shared.getPrograms()
    }
    
    let router: RouterViewModel
    
    init(router: RouterViewModel) {
        self.router = router
        self.programs = ProgramsViewModel.getPrograms()
    }
    
    func startTraining() {
        
        let selectedExerciseNames = programs.filter { $0.id == selectedProgramId }
        if selectedExerciseNames.count > 0 {
            router.program = selectedExerciseNames[0]
        }
       
        router.startTraining()
    }
}

