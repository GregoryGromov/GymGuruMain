import Foundation

struct DayForCalendar: Identifiable {
    let id = UUID().uuidString
    
    let date: Date
    let trainings: [Training]
}
