//
//  TrainingsStaticticsViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 15.02.2024.
//

import Foundation
import Combine
import SwiftUI


class TrainingsStatisticsService {
    
    static let shared = TrainingsStatisticsService()
    
    var allTrainings: [Training]
    
    @Published var countOfBars = 1 {
        didSet {
            updateRange()
        }
    }
    
    @Published var trainingsOfTheRange = [Training]()
    
    private var cancellable: AnyCancellable?
    
    init() {
        
        let traingsFormCoreData = DataMOCK.shared.TrainingsMOCK
//        traingsFormCoreData.sorted {$0.date > $0.date}
        self.allTrainings = traingsFormCoreData
        
        updateRange()
        
        cancellable = $countOfBars.sink { _ in
            self.updateRange()
        }
    }
    
    private func updateRange() {
        trainingsOfTheRange = Array(allTrainings.prefix(countOfBars))
    }
}





