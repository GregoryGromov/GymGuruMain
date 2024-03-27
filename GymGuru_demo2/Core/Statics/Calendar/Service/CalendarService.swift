//
//  CalendarViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.03.2024.
//

import SwiftUI

class CalendarService: ObservableObject {
    
    
    
    
    
    func convertSecondsToDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        var durationString = ""
        
        if seconds < 3600 {
            durationString = String(format: "%02d:%02d", minutes, seconds)
        } else if hours < 10 {
            durationString = String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            durationString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        return durationString
    }
    
    
    
    
    let calendar = Calendar.current
    let daysOfWeek = ["П", "В", "С", "Ч", "П", "С", "В"]
    
    var days: [Date] = []
    
    //эта переменаая отвечает за хранения даты, к которой привязан каленарь
    @Published var date = Date.now
    
    @Published var daysForCalendar: [DayForCalendar] = []
    var daysForColenderThisWeek = [DayForCalendar]()
    
    //эта переменная - хранение нажатой даты выбранной даты
    @Published var selectedDate: Date? = nil
    @Published var selectedDateTrainings = [Training]()
    
    
    
    
    let startPeriodDate = Calendar.current.date(byAdding: .day, value: -7, to: Date().startOfMonth)!
    private var trainingsPerThisPeriod = [Training]()
    
    
    init() {
        self.trainingsPerThisPeriod = DataMOCK.shared.TrainingsMOCK.filter {$0.date > startPeriodDate}
        
        let daysThisWeek = date.weekDisplayDays
        
        for day in daysThisWeek {
            let dayNumber = calendar.component(.day, from: day)
            let dayMonth = calendar.component(.month, from: day)
            let dayYear = calendar.component(.year, from: day)
            
            var dayTrainings = [Training]()
            
            //оптимизировать: если что-то нашли, а потом не нашли - закончить цикл
            for training in trainingsPerThisPeriod {
                let trainingDayNuber = calendar.component(.day, from: training.date)
                let trainingDayMonth = calendar.component(.month, from: training.date)
                let trainingYear = calendar.component(.year, from: training.date)
                
                if trainingDayNuber == dayNumber && trainingDayMonth == dayMonth && trainingYear == dayYear {
                    dayTrainings.append(training)
                }
            }
            
            let newDayForCalendar = DayForCalendar(
                date: day,
                trainings: dayTrainings
            )
            
            self.daysForColenderThisWeek.append(newDayForCalendar)
        }
    }
    
    
    
    private func get15thDayOfPreviousMonth(from date: Date) -> Date? {
        let calendar = Calendar.current
        
        // Находим первый день текущего месяца
        guard let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return nil }
        
        // Получаем дату, соответствующую одному дню перед первым числом текущего месяца
        guard let lastDayOfPreviousMonth = calendar.date(byAdding: .day, value: -1, to: firstDayOfCurrentMonth) else { return nil }
        
        // Теперь, имея последний день предыдущего месяца, находим 15-е число того же месяца
        var components = calendar.dateComponents([.year, .month], from: lastDayOfPreviousMonth)
        components.day = 15
        
        return calendar.date(from: components)
    }
    
    
    func get15thDayOfNextMonth(from date: Date) -> Date? {
        let calendar = Calendar.current
        
        // Находим первый день текущего месяца, чтобы гарантированно находиться в нужном месяце
        guard let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return nil }
        
        // Получаем дату, соответствующую первому числу следующего месяца
        guard let firstDayOfNextMonth = calendar.date(byAdding: .month, value: 1, to: firstDayOfCurrentMonth) else { return nil }
        
        // Теперь, имея первый день следующего месяца, находим 15-е число того же месяца
        var components = calendar.dateComponents([.year, .month], from: firstDayOfNextMonth)
        components.day = 15
        
        return calendar.date(from: components)
    }
    
    
    func switchToPreviousMonth() {
        if let previousMonthDate = get15thDayOfPreviousMonth(from: date) {
            date = previousMonthDate
        }
        selectedDate = nil
    }
    
    func switchToNextMonth() {
        if let nextMonthDate = get15thDayOfNextMonth(from: date) {
            date = nextMonthDate
        }
        selectedDate = nil
    }
    
    
    func reloadCalendarData() {
        days = date.calendarDisplayDays
        var daysOfThisMonth = [DayForCalendar]()
        
        for day in days {
            let dayNumber = calendar.component(.day, from: day)
            let dayMonth = calendar.component(.month, from: day)
            let dayYear = calendar.component(.year, from: day)
            
            
            
            var dayTrainings = [Training]()
            
            //оптимизировать: если что-то нашли, а потом не нашли - закончить цикл
            for training in trainingsPerThisPeriod {
                let trainingDay = calendar.component(.day, from: training.date)
                let trainingMonth = calendar.component(.month, from: training.date)
                let trainingYear = calendar.component(.year, from: training.date)
                
                if trainingDay == dayNumber && trainingMonth == dayMonth && trainingYear == dayYear {
                    dayTrainings.append(training)
                }
            }
            
            let newDayForCalendar = DayForCalendar(
                date: day,
                trainings: dayTrainings)
            
            daysOfThisMonth.append(newDayForCalendar)
            
            daysForCalendar = daysOfThisMonth
        }
    }
    
    func setSelectedDay(to day: Date) {
        self.selectedDate = day
    }
    
    func setSelectedDayTrainings(trainings: [Training]) {
        self.selectedDateTrainings = trainings
    }
}


