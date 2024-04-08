//
//  ExerciseStatisticsService.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import Foundation


//преднзначена для хранения данных о максимальном весе за тренировку для конкретного упражнения


class ExerciseStatisticsService: ObservableObject {
        
    @Published var chartInfo = [ChartExerciseInfo]()
    
    @Published var exerciseNames = [String]()
    
    init() {
        //тут будет обращение к CoreData
        let trainings = DataMOCK.shared.TrainingsMOCK
        
        let exerciseStatistics = fetchExerciseMaxWeightStatistics(fromTrainings: trainings)
        let exercisesByPopularity = sortExercisesByPopularity(exerciseStatistics)
        
        self.exerciseNames = exercisesByPopularity
        
        self.chartInfo = convertExerciseStatisticsToChartExerciseInfo(
            exerciseStatistics: exerciseStatistics,
            exercisePopularity: exercisesByPopularity)
    }
    
    
    // WECM - WidgetExerciseChartModel
    func findExerciseInfo(byName exerciseName: String) -> ChartExerciseInfo {
        
        for wecm in chartInfo {
            if wecm.exerciseName == exerciseName {
                return wecm
            }
        }
        
        return chartInfo[0]
    }
    
    
    
    //ChartExerciseInfo - по сути отсортированный по популярности упражнений ExerciseStatistics, представленный в формате более удобном для построения графика (то есть [ChartExerciseInfo])
    
    func convertExerciseStatisticsToChartExerciseInfo(exerciseStatistics: [String:[WeightDateItem]], exercisePopularity: [String]) -> [ChartExerciseInfo] {
        
        var chartExercisesInfo = [ChartExerciseInfo]()
        
        for exerciseName in exercisePopularity {
            if let points = exerciseStatistics[exerciseName] {
                let newChartExerciseInfoItem = ChartExerciseInfo(
                    exerciseName: exerciseName,
                    points: points.sorted { $0.date < $1.date }
                )
                chartExercisesInfo.append(newChartExerciseInfoItem)
            }
        }
        
        return chartExercisesInfo
    }
    
    
    
    
    
    
    //Вход: все тренировки в формате [Training]
    //Выход: данные о макимальном весе за тренировку в формате: [String:[WeightDateItem]],
        //где, String - название упражнения
    
    func fetchExerciseMaxWeightStatistics(fromTrainings trainings: [Training]) -> [String:[WeightDateItem]] {
        
        var exerciseStatistics = [String:[WeightDateItem]]()
        
        for training in trainings {
            for exercise in training.exercises {
                
                let maxWeight = findMaxWeigth(sets: exercise.sets)
                
                let newWeightDateItem = WeightDateItem(
                    date: training.date,
                    maxWeight: Int(maxWeight)
                    )
                
                if let _ = exerciseStatistics[exercise.name] {
                    exerciseStatistics[exercise.name]?.append(newWeightDateItem)
                } else {
                    exerciseStatistics[exercise.name] = [newWeightDateItem]
                }
            }
        }
        return exerciseStatistics
    }
    
    func sortExercisesByPopularity(_ exercisesWithWeights: [String:[WeightDateItem]]) -> [String] {
        var exercisePopularity = [String:Int]()
        
        for key in exercisesWithWeights.keys {
            let exerciseName = key
            let exerciseAmount = exercisesWithWeights[key]?.count
            
            exercisePopularity[exerciseName] = exerciseAmount
        }
        
        let sortedExercises = exercisePopularity.keys.sorted { key1, key2 in
            if let value1 = exercisePopularity[key1] {
                if let value2 = exercisePopularity[key2] {
                    return value1 > value2
                }
            }
            return false
        }
        
        return sortedExercises
    }
    
    private func findMaxWeigth(sets: [Set]) -> Float {
        var maxWeight = sets[0].weight
        
        for set1 in sets {
            if set1.weight > maxWeight {
                maxWeight = set1.weight
            }
        }
        return maxWeight
    }
}



