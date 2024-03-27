//
//  ExerciseStaticticsViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import Foundation

struct graphScale: Identifiable {
    let id = UUID().uuidString
    
    let name: ChartPeriod
    let date: Date
}



class ExerciseStaticticsViewModel: ObservableObject {
    
    let chartInfo: ChartExerciseInfo
    
    var scaleOptions = [graphScale(name: .month1, date: TimePeriods.month1)]
    
    init(chartInfo: ChartExerciseInfo) {
        
        self.chartInfo = chartInfo
        
        
        // необходимо понять, какие у нас будут кнопки масштабирования графика
        var measurementPeriod: TimeInterval = TimeInterval(0)
        
        if let firstDate = chartInfo.points.first {
            if let lastDate = chartInfo.points.last {
                let interval = lastDate.date.timeIntervalSince(firstDate.date) //в секундах
                measurementPeriod = interval
            }
        }
        
        
        
//        if measurementPeriod > Date().timeIntervalSince(TimePeriods.month1) {
//            let newScaleOption = graphScale(name: .month1, date: TimePeriods.month1)
//            scaleOptions.append(newScaleOption)
//        }
        if measurementPeriod > Date().timeIntervalSince(TimePeriods.month3) {
            let newScaleOption = graphScale(name: .month3, date: TimePeriods.month3)
            scaleOptions.append(newScaleOption)
        }
//        if measurementPeriod > Date().timeIntervalSince(TimePeriods.month6) {
//            let newScaleOption = graphScale(name: "M6", date: TimePeriods.month6)
//            scaleOptions.append(newScaleOption)
//        }
        
        
    }
}
