import Foundation

extension Date {
    static var firstDayOfWeek = Calendar.current.firstWeekday
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        var weekdays = calendar.shortWeekdaySymbols
        if firstDayOfWeek > 1 {
            for _ in 1..<firstDayOfWeek {
                if let first = weekdays.first {
                    weekdays.append(first)
                    weekdays.removeFirst()
                }
            }
        }
        return weekdays.map { $0.capitalized }
    }
    
    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    //возвращает первый день месяца этого дня
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    //возвращает последний день месяца этого дня
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    //первый день предыдущего месяца
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    
    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    

    var firstWeekDayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    
    
    var weekDisplayDays: [Date] {
        let days = self.calendarDisplayDays
        
        var counter = 0
        
        
        
//  Это для тестирования виджета, чтобы вручную задавать даты
//        let calendar = Calendar.current
//        let year = 2023
//        let month = 12
//        let day = 28
//
//        // Создаем компоненты даты на основе года, месяца и дня
//        var dateComponents = DateComponents()
//        dateComponents.year = year
//        dateComponents.month = month
//        dateComponents.day = day
//
//        // Создаем Date на основе компонентов даты
//        let dateForTest = calendar.date(from: dateComponents)!
 
            
    outerLoop:
        for day in days {
            counter += 1
            if Date.now.startOfDay == day.startOfDay {
            //if dateForTest == day.startOfDay {
                break outerLoop
            }
        }
        
        let intPart = (counter  - 1) / 7
         
        var startIndex = 0

        switch intPart {
        case 0: break
        case 1: startIndex = 7
        case 2: startIndex = 14
        case 3: startIndex = 21
        case 4: startIndex = 28
        default:
            break
        }
        
        let endIndex = startIndex + 7
        
        let slicedArray = Array(days[startIndex..<endIndex])
        
        return slicedArray
    }
    
    
    
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        
        
        
        
        
        
        
        
        var filteredDays = days.filter { $0 >= firstWeekDayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
        
        
        
        
        //Решаем проблему "января 2023" - неделя начинается с 2
        
// // // --------------------------------------------------------------------->
        
        if filteredDays[0].formatted(.dateTime.day()) == "2" {
            print("Вот и все - приплыли")
            print("\(filteredDays[0]), type: \(type(of: filteredDays[0]))")
            if let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: filteredDays[0]) {
                filteredDays.insert(dayBefore, at: 0)
                
                var dayBeforeBefor = Calendar.current.date(byAdding: .day, value: -1, to: dayBefore)
                if dayBeforeBefor != nil {
                    filteredDays.insert(dayBeforeBefor!, at: 0)
                    
                }
                
                for _ in 1...5 {
                    if dayBeforeBefor != nil {
                        dayBeforeBefor = Calendar.current.date(byAdding: .day, value: -1, to: dayBeforeBefor!)
                        if dayBeforeBefor != nil {
                            filteredDays.insert(dayBeforeBefor!, at: 0)
                        }
                    }
                }
                
                
                //если нам не нужно отображение предыдущих дней
//                if let dayBeforeBefore = Calendar.current.date(byAdding: .day, value: -1, to: dayBefore) {
//                    filteredDays.insert(dayBeforeBefore, at: 0)
//                    for _ in 1...5 {
//                        if let dayBeforeBefore = Calendar.current.date(byAdding: .day, value: -1, to: dayBeforeBefore) {
//
//                            filteredDays.insert(dayBeforeBefore, at: 0)
//                        }
//
//
//                    }
//                }
               
// // // <---------------------------------------------------------------------
                
                
            }

        }
        
        
        //плюс нужно добавить дни после:
        print("Количество дней: \(filteredDays.count)")
        let ost = filteredDays.count % 7
        
        if ost > 0 {
            print("Зашли")
            var nextDay = self.startOfNextMonth
            for _ in 1...(7-ost) {
                print("Хи")
                nextDay = Calendar.current.date(byAdding: .day, value: 1, to: nextDay)!
                filteredDays.append(nextDay)
            }
        }
        
        print("Количество дней: \(filteredDays.count)")
//        filteredDays = days.filter { $0 >= firstWeekDayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
        
        filteredDays = filteredDays.filter { $0 >= firstWeekDayBeforeStart  }.sorted(by: <)
        
        print("Количество дней: \(filteredDays.count)")
            
        return filteredDays
        
        
        
            
        
    }
        
        var monthInt: Int {
            Calendar.current.component(.month, from: self)
        }
        
        var startOfDay: Date {
            Calendar.current.startOfDay(for: self)
        }
    
}
