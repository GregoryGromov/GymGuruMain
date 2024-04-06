//
//  SelectMuscleGroupViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 21.12.2023.
//

import Foundation

class SelectMuscleGroupViewModel: ObservableObject {
    
    
    
    
   
    @Published var allExerciseItems = ExerciseService.shared.buildInExercisesItems
    
    
    @Published var showAddExerciseView = false
    
    
    
    
    
    let trainingViewModel: TrainingViewModel
    
    init(trainingViewModel: TrainingViewModel) {
        self.trainingViewModel = trainingViewModel
    }
    
    let muscleGroups = ExerciseService.shared.muscleGroups
    
    // !!!
    @Published var exerciseItems = ExerciseService.shared.buildInExercisesItems
    
    var amountOfSelectedExercises: Int {
        return exerciseItems.filter({$0.isSelected}).count
    }
    
    
    
    
    
    func selectExercise(exercise: ExerciseItem) {
        print("We here #1")
        for index in 0...(allExerciseItems.count-1) {
            if allExerciseItems[index].name == exercise.name {
                print("We here #2")
                allExerciseItems[index].isSelected.toggle()
            }
        }
    }
    
    func addNewExerciseItems() {
        trainingViewModel.addedExercises = []
        
        for exercise in allExerciseItems {
            if exercise.isSelected {
                trainingViewModel.addedExercises.append(exercise)
            }
        }
    }
    
    
    func addSelectedExercisesToTraining() {
        let exercises = convertExerciseItemsToExercises(exerciseItems: trainingViewModel.addedExercises)
        for exercise in exercises {
            //!!! мы не должны иметь прямого досутпа к свойствам класса - исправить: сделать в классе функцию сеттер
            trainingViewModel.currentTraining.exercises.append(exercise)
            trainingViewModel.saveTraining()
        }
    }
    
    
    
    
    
    
    
    func switchIsSelected(exercise: ExerciseItem) {
        for i in 0...(exerciseItems.count - 1) {
            if exerciseItems[i].name == exercise.name {
                exerciseItems[i].isSelected.toggle()
                return
            }
        }
    }
    
    
    func addSelectedExercises() {
        let selectedExercieItems = detectSelectedExerciseItems()
        let selectedExercises = convertExerciseItemsToExercises(exerciseItems: selectedExercieItems)
        for exercise in selectedExercises {
            trainingViewModel.currentTraining.exercises.append(exercise)
            print(trainingViewModel.currentTraining.exercises)
        }
        trainingViewModel.saveTraining()
    }
    
    private func detectSelectedExerciseItems() -> [ExerciseItem] {
        var selectedExercises: [ExerciseItem] = []
        
        for i in 0...(exerciseItems.count - 1) {
            if exerciseItems[i].isSelected {
                selectedExercises.append(exerciseItems[i])
            }
        }
        return selectedExercises
    }
    
    private func convertExerciseItemsToExercises(exerciseItems: [ExerciseItem]) -> [Exercise] {
        var exercises: [Exercise] = []
        for exerciseItem in exerciseItems {
            let exercise = Exercise(
                id: UUID().uuidString,
                name: exerciseItem.name,
                muscleGroup: exerciseItem.muscleGroup,
                isBodyweight: exerciseItem.isBodyweight,
                sets: [])
            exercises.append(exercise)
        }
        return exercises
    }
}
