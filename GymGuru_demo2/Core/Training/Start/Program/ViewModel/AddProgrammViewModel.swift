//
//  AddProgrammViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 23.03.2024.
//

import SwiftUI







class AddProgrammViewModel: ObservableObject {
    
    
    
    
    let motherViewModel: TrainingStartViewModel
    
    @Published var addedExercises: [ExerciseItem] = []
    @Published var allExerciseItems = ExerciseService.shared.buildInExercisesItems
    
    
    @Published var showAddExerciseView = false
    @Published var programName = ""
    @Published var selectedColor: Color? = nil
    
    init(motherViewModel: TrainingStartViewModel) {
        self.motherViewModel = motherViewModel
    }


    
    
    let colors: [Color] = [
        Color.red,
        Color.blue,
        Color.green,
        Color.yellow,
        Color.orange,
        Color.purple
    ]
    
    func cleanProgramPlaceholder() {
        programName = ""
        selectedColor = nil
        addedExercises = []
        allExerciseItems = ExerciseService.shared.buildInExercisesItems
    }
    
    func addNewExerciseItems() {
        addedExercises = []
        
        for exercise in allExerciseItems {
            if exercise.isSelected {
                addedExercises.append(exercise)
            }
        }
    }
    
    
    func selectExercise(exercise: ExerciseItem) {
        for index in 0...(allExerciseItems.count-1) {
            if allExerciseItems[index].name == exercise.name {
                allExerciseItems[index].isSelected.toggle()
            }
        }
    }
    
    func moveUp(exerciseItemName: String) {
        for index in 0...(addedExercises.count-1) {
            if addedExercises[index].name == exerciseItemName {
                if index != 0 {
                    let tmp = addedExercises[index-1]
                    addedExercises[index-1] = addedExercises[index]
                    addedExercises[index] = tmp
                    return
                } else {
                    return
                }
            }
        }
    }
    
    func moveDown(exerciseItemName: String) {
        for index in 0...(addedExercises.count-1) {
            if addedExercises[index].name == exerciseItemName {
                if index != (addedExercises.count-1) {
                    let tmp = addedExercises[index+1]
                    addedExercises[index+1] = addedExercises[index]
                    addedExercises[index] = tmp
                    return
                } else {
                    return
                }
            }
        }
    }
    
    func saveProgram() {
        
        var programColor = Color.gray
        
        if let color = selectedColor {
            programColor = color
        }
        
        var namesOfExercises: [String] = []
        
        for exercise in addedExercises {
            namesOfExercises.append(exercise.name)
        }
        
        let newProgram = Program(
            id: UUID().uuidString,
            name: programName,
            exercises: namesOfExercises,
            color: programColor
        )
        
        CoreDataManager.shared.addProgram(program: newProgram) 
        
        // этот момент надо пофиксить
        motherViewModel.programs = []
        motherViewModel.programs = ProgramsViewModel.getPrograms()
    }
}




