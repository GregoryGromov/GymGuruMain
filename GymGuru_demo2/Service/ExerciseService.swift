//
//  ExerciseService.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 09.02.2024.
//

import Foundation

class ExerciseService {
    
    static let shared = ExerciseService()
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let userExercisesKey = "UsersExercises"
    
    let buildInExercisesItems = [
        ExerciseItem(name: "Подгягивание", muscleGroup: ["Arms", "Back"], isBodyweight: true, isSelected: false),
        ExerciseItem(name: "Жим лежа", muscleGroup: ["Chest", "Shoulders"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Скручивание", muscleGroup: ["ABS"], isBodyweight: true, isSelected: false),
        ExerciseItem(name: "Тяга блока сидя", muscleGroup: ["Back"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Тяга блока стоя", muscleGroup: ["Back"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Присед", muscleGroup: ["Legs"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Выход силой", muscleGroup: ["Arms", "Arms"], isBodyweight: true, isSelected: false),
    ]
    
    //ИСПРАВИТЬ: сделать, чтобы группы мышц высчитывались автоматически на основе того, какие упражнения есть
    let muscleGroups = ["Arms", "Chest", "ABS", "Shoulders", "Legs", "Back", "Your"]
    
    

    
    
    //Добавление собственного упражнения
    func saveCustomExercise(exercise: ExerciseItem) {
        var existingExercises = fetchCustomExercises()
        existingExercises.append(exercise)
        saveExerciseToUD(exercises: existingExercises)
    }
    
    
    //Получение собственных упражнений
    func fetchCustomExercises() -> [ExerciseItem] {
        var usersExercises: [ExerciseItem] = []
        
        if let encodedExercise = defaults.object(forKey: userExercisesKey) as? Data {
            if let decodedExercise = try? decoder.decode([ExerciseItem].self, from: encodedExercise) {
                for exercise in decodedExercise {
                    usersExercises.append(exercise)
                }
            }
        }
        return usersExercises
    }
    
    
    //Сохранение массива [ExerciseItem] в UserDefaults
    private func saveExerciseToUD(exercises: [ExerciseItem]) {
        if let encoded = try? encoder.encode(exercises) {
            defaults.set(encoded, forKey: userExercisesKey)
        }
    }
    
    //Удаление всех пользовательсктх упражнений из UserDefaults
    func deleteAllExerciseFromAppStorage() {
        let existingExerciseItems: [Exercise] = []
        if let encoded = try? encoder.encode(existingExerciseItems) {
            defaults.set(encoded, forKey: userExercisesKey)
        }
    }
}
