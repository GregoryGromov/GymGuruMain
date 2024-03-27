//
//  ProgramsViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 27.03.2024.
//

import Foundation


class ProgramsViewModel: ObservableObject {
    
    @Published var programs: [Program]
    
    @Published var showAddProgramView = false
    
    @Published var selectedProgramId = ""
    

    
    init() {
        self.programs = ProgramsViewModel.getPrograms()
    }
    
    static func getPrograms() -> [Program] {
        return CoreDataManager.shared.getPrograms()
    }
    
}
