//
//  TimerBarViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 02.04.2024.
//

import Foundation

struct TimeValue: Identifiable, Codable {
    let id: String
    let seconds: Int
    var isFavourite: Bool
}




class TimerBarViewModel: ObservableObject {
    
    
    
    @Published var timeValues: [TimeValue]
    @Published var favoriteTimeValues: [TimeValue] = []
    
    
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        if TimeBarService.shared.didUserEditTimeValues() {
            if let existingTimeValues = TimeBarService.shared.fetchTimeValues() {
                self.timeValues = existingTimeValues
                return
            }
        }
            
        self.timeValues = [
            TimeValue(id: UUID().uuidString, seconds: 240, isFavourite: true),
            TimeValue(id: UUID().uuidString, seconds: 400, isFavourite: true),
            TimeValue(id: UUID().uuidString, seconds: 600, isFavourite: true),
        ]
    }
    
    func createNewTimeValue(seconds: Int) {
        let newTimeValue = TimeValue(
            id: UUID().uuidString,
            seconds: seconds,
            isFavourite: false
        )
        addTimeValue(newTimeValue)
    }
    
    private func addTimeValue(_ timeValue: TimeValue) {
        TimeBarService.shared.setTimeValues(timeValues: timeValues)
        TimeBarService.shared.setTimeValuesHasBeenEdited()
    }
    
    func deleteTimeValue(_ timeValue: TimeValue) {
        for index in timeValues.indices {
            if timeValues[index].id == timeValue.id {
                timeValues.remove(at: index)
                TimeBarService.shared.setTimeValues(timeValues: timeValues)
                TimeBarService.shared.setTimeValuesHasBeenEdited()
                return
            }
        }
    }
    
    func addToFavourite(_ timeValue: TimeValue) {
        if timeValues.filter({$0.isFavourite}).count < 3 {
            switchIsFavourite(timeValue)
        } else {
            print("В избранном может быть не больше 3 объектов")
        }
    }
    
    func switchIsFavourite(_ timeValue: TimeValue) {
        for index in timeValues.indices {
            if timeValues[index].id == timeValue.id {
                timeValues[index].isFavourite.toggle()
                TimeBarService.shared.setTimeValues(timeValues: timeValues)
                TimeBarService.shared.setTimeValuesHasBeenEdited()
                return
            }
        }
    }
    
    
    func convertSecondsToMins(_ seconds: Int) -> String {
        
            if seconds % 30 == 0 {
                let amountOfHalfMinutes = seconds / 30
                if amountOfHalfMinutes % 2 == 0 {
                    return "\(amountOfHalfMinutes / 2)"
                } else {
                    return "\(amountOfHalfMinutes / 2).5"
                }
            } else {
                return "228"
            }
        
    }
}


class TimeBarService {
    
    static let shared = TimeBarService()
    
    
    
    let favoriteTimeValuesKey = "FTVKey"
    let timeValuesKey = "TVKey"
    let timeEditingKey = "editTVKey"
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func fetchTimeValues() -> [TimeValue]? {
        if let encodedTimeValues = defaults.object(forKey: timeValuesKey) as? Data {
            print("DEBUG: TV получены из UD")
            if let decodedTimeValues = try? decoder.decode([TimeValue].self, from: encodedTimeValues) {
                print("DEBUG: TV декодированна")
                return decodedTimeValues
            } else {
                return nil
            }
        }
        return nil
    }
    
    func setTimeValues(timeValues: [TimeValue]) {
        if let encodedTimeValues = try? encoder.encode(timeValues) {
            defaults.set(encodedTimeValues, forKey: timeValuesKey)
            print("DEBUG: TV успешно сохранена")
        }
    }
    
    func didUserEditTimeValues() -> Bool {
        let answer = defaults.bool(forKey: timeEditingKey)
        return answer
    }
    
    
    func setTimeValuesHasBeenEdited() {
        defaults.set(true, forKey: timeEditingKey)
    }
    
    func addNewTimeValue(_ timeValue: TimeValue) {
        if var existingTimeValues = fetchTimeValues() {
            existingTimeValues.append(timeValue)
            setTimeValues(timeValues: existingTimeValues)
        }
    }
    
    
}
