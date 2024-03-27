import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "GymGuru")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("DEBUG: Не удалось загрузить данные из CoreData: \(error.localizedDescription)")
            } else {
                print("DEBUG: Инициализация CoreDataManager: данные успешно загружены из CoreData")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("DEBUG: Error saving data in Core Data: \(error.localizedDescription)")
        }
    }
    
    
    func addWeightNote(note: WeightItem) {
        let newWeightEntity = WeightEntity(context: context)
        newWeightEntity.id = note.id
        newWeightEntity.date = note.date
        newWeightEntity.weight = note.weight
        
        save()
    }
    
    
    func addProgram(program: Program) {
        let newProgramEntity = ProgramEntity(context: context)
        newProgramEntity.id = program.id
        newProgramEntity.name = program.name
        newProgramEntity.exercises = program.exercises as NSObject
        
        save()
    }
    
    
    
    func getPrograms() -> [Program] {
        let request = NSFetchRequest<ProgramEntity>(entityName: "ProgramEntity")
        
        var programs: [Program] = []
        
        do {
            let fetchedProgramEntities = try context.fetch(request)
            
            for programEntity in fetchedProgramEntities {
                let newProgram = Program(
                    id: programEntity.id ?? UUID().uuidString,
                    name: programEntity.name ?? "",
                    exercises: programEntity.exercises as? [String] ?? [],
                    color: .gray
                )
                programs.append(newProgram)
            }
        } catch {
            print("DEGUG: Ошибка при загрузке данных о программах тренировок из CoreData: \(error.localizedDescription)")
        }
        
        return programs
    }
    
    
    func getWeightNotes() -> [WeightItem] {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        
        var weightNotes: [WeightItem] = []
        
        do {
            let fetchedWeightEntities = try context.fetch(request)
            
            for weightEntity in fetchedWeightEntities {
                let newWeightItem = WeightItem(
                    id: weightEntity.id ?? UUID().uuidString,
                    weight: weightEntity.weight,
                    date: weightEntity.date ?? Date()
                )
                weightNotes.append(newWeightItem)
            }
        } catch {
            print("DEGUG: Ошибка при загрузке данных о весе из CoreData: \(error.localizedDescription)")
        }
        
        return weightNotes
    }
    
    func deleteWeightNote(byId id: String) {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        
        do {
            let fetchedWeightNotes = try context.fetch(request)
            
            for weightNote in fetchedWeightNotes {
                if weightNote.id == id {
                    context.delete(weightNote)
                    save()
                    return
                }
            }
        } catch {
            print("DEBUG: Ошибка при удалении TrainingEntyty")
        }
    }

    
    
    
    func getTrainings() -> [Training] {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        
        var trainings: [Training] = []
        
        do {
            //загружаем тренировки в формате TrainingEntity
            let fetchedTrainings = try context.fetch(request)
            
            for trainingEntity in fetchedTrainings {
                                                                        // ТАКОЕ
                let exerciseEntitys = trainingEntity.exercises?.allObjects as! [ExerciseEntity]
                
                print("DB3: exerciseEntitys.count = \(exerciseEntitys.count)")
                
                var exercises: [Exercise] = []
                
                
                //перебираем упражнения данной тренировки в формате ExerciseEntity
                for exerciseEntity in exerciseEntitys {
                    
                    var setsAsSet: [Set] = []
                    
                                                                // ТАКОЕ
                    let setEntitys = exerciseEntity.sets?.allObjects as! [SetEntity]
                    
                    //перебираем сеты этой тренировки в формате SetEntity
                    for setEntity in setEntitys {
                        let newSet = Set(
                            // ТАКОЕ
                            id: setEntity.id!,
                            date: setEntity.date!,
                            weight: setEntity.weight,
                            amount: Int(setEntity.amount)
                        )
                        setsAsSet.append(newSet)
                    }
                    
                    let exercise = Exercise(
                        id: exerciseEntity.id!,
                        name: exerciseEntity.name!,
                        muscleGroup: [],
                        isBodyweight: exerciseEntity.isBodyweight,
                        sets: setsAsSet,
                        isFolded: true)
                    
                    exercises.append(exercise)
                }
                
                let training = Training(
                    id: trainingEntity.id ?? "", //!!!
                    date: trainingEntity.date ?? Date(), //!!!
                    dateEnd: trainingEntity.dateEnd ?? Date(), //!!!
                    exercises: exercises
                )
                trainings.append(training)
            }
            print("DEGUG: Данные о всех тренировках загружены из CoreData")
        } catch {
            print("DEGUG: Ошибка при загрузке данных о тренировках из CoreData: \(error.localizedDescription)")
        }
        
        return trainings
    }
    
    
    
    
    
    
    func addTraining(training: Training) {
        
       // print("DEGUG: на моменте входа в тренировке \(training.exercises.count) упражнений")
        
        let newTrainingEntity = TrainingEntity(context: context)
        newTrainingEntity.id = training.id
        newTrainingEntity.date = training.date
        
        if let dateEnd = training.dateEnd {
            newTrainingEntity.dateEnd = dateEnd
        }
        
        for exercise in training.exercises {
            
            let newExercise = ExerciseEntity(context: context)
            newExercise.id = exercise.id
            newExercise.name = exercise.name
            newExercise.date = exercise.date
            newExercise.isBodyweight = exercise.isBodyweight
            newExercise.muscleGroups = exercise.muscleGroup as NSObject
            
            for set_ in exercise.sets {
                let newSet = SetEntity(context: context)
                
                newSet.id = set_.id
                newSet.date = set_.date
                newSet.weight = set_.weight
                newSet.amount = Int16(set_.amount)
                
                newSet.exercise = newExercise
   
            }
            newExercise.training = newTrainingEntity
      
        }
        
        save()
    }
    
    func deleteTraining() {
        
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        
        
        do {
            let fetchedTrainings = try context.fetch(request)
            
            for trainingEntity in fetchedTrainings {
                context.delete(trainingEntity)
                save()
            }
        } catch {
            print("DEBUG: Ошибка при удалении TrainingEntyty")
        }
    }
}
