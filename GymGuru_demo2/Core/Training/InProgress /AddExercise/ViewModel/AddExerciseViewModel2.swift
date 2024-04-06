//
//  SelectMuscleGroupView2.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 01.04.2024.
//

import Foundation

class AddExerciseViewModel2: ObservableObject {
    
    
    
    
    
    let trainingViewModel: TrainingViewModel
    
    init(trainingViewModel: TrainingViewModel) {
        self.trainingViewModel = trainingViewModel
        
        //все возможные упражнения типа exerciseItem (пока у них у все isSelected = false)
        var allExerciseItems = ExerciseService.shared.buildInExercisesItems
        
        //сохраним, какие упражнения типа EI уже были в тренировке в момент инициализации этого класса
        var addedExerciseItems: [ExerciseItem] = []
        
        //упражнения типа exercise, которые уже находятся в тренировке
        let alredyAddedExercises = trainingViewModel.currentTraining.exercises
        
        for exercise in alredyAddedExercises {
            for index in allExerciseItems.indices {
                if allExerciseItems[index].name == exercise.name {
                    allExerciseItems[index].isSelected = true
                    allExerciseItems[index].previouslySelected = true
                    addedExerciseItems.append(allExerciseItems[index])
                }
            }
        }
        
        self.allExerciseItems = allExerciseItems
        self.addedExerciseItems = addedExerciseItems
    }
    
    

    
    
    @Published var allExerciseItems: [ExerciseItem]
    private var addedExerciseItems: [ExerciseItem]
    
    let muscleGroups = ["Chest", "Arms", "Legs", "ABS", "Back"]
    
    
    @Published var showAddExerciseView = false
    @Published var bufferedExerciseItems: [ExerciseItem] = []
    
    
    
    func switchExerciseItemSelection(exercise: ExerciseItem) {
        for index in 0...(allExerciseItems.count-1) {
            if allExerciseItems[index].name == exercise.name {
                //мы нашли в списке всех упражнений выбранное упражнение
                
                
                //смотри, не было ли добавлено это упражнение в прошлый заход (то есть нет ли его в тренировке уже)
//                for addedExercise in addedExerciseItems {
//                    if addedExercise.name == allExerciseItems[index].name {
//                        //если оно уже добавлено - ничего не делаем (то есть не убираем галочку)
//                        print("ToUser: вы хотите удалить упражнение, которое уже есть в тренировке. Вы можете сделать это непосредственно в разделе тренировка")
//                        print("#1")
//                        return
//                    }
//                }
                
                if let _ = allExerciseItems[index].previouslySelected {
                //    если оно уже добавлено - ничего не делаем (то есть не убираем галочку)
                    print("ToUser: вы хотите удалить упражнение, которое уже есть в тренировке. Вы можете сделать это непосредственно в разделе тренировка")
                    print("#1")
                    return
                }
                
                //если мы тут, значит выбранное упражнение не было добавлено в прошлый заход (то есть этого упражнения еще нет в тренировке)
                
                //смотрим, добавленно ли оно уже в буфер
                for index2 in bufferedExerciseItems.indices {
                    if exercise.name == bufferedExerciseItems[index2].name {
                        //если уже добавлено
                        bufferedExerciseItems.remove(at: index2)
                        allExerciseItems[index].isSelected = false
                        print("#2")
                        return
                    }
                }
                
                //если мы тут, значит этого упражнения нет ни в буффере, ни в добавленных ранее
                //тогда добовляем его в буффер
                
                bufferedExerciseItems.append(exercise)
                allExerciseItems[index].isSelected.toggle()
                
                print("#3")
            }
        }
    }
    
    func returnNewExercises() -> [Exercise] {
        let newExerciseItems = bufferedExerciseItems
        let newExercises = convertExerciseItemsToExercises(exerciseItems: newExerciseItems)
        bufferedExerciseItems = [] //?? хз, насколько это соответствует названию функции
        
        return newExercises
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
    
    
    func addNewExercisesToTraining() {
        let selectedExercises = returnNewExercises()
        for exercise in selectedExercises {
            trainingViewModel.currentTraining.exercises.append(exercise)
        }
        
        trainingViewModel.saveTraining()
        
    }
    
    
    
}
