//
//  WeightStatisticsViewModel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 06.04.2024.
//

import Foundation

class WeightStatisticsViewModel: ObservableObject {
    
    @Published var weightNotes: [WeightNote]
    @Published var dateOfNoteCreation = Date.now
    
    @Published var showListOfItems = true
    @Published var showDeletingAlert = false
    @Published var deletingItem: WeightNote? = nil
    @Published var weight: Float = 0
    @Published var showAddWeightView = false

    
    @Published var notesPerSelectedPeriod: [WeightNote]
    @Published var chartPeriod: ChartPeriod = .month1
    
    init() {
        let currentDate = Date()
        let month1InSeconds = 60*60*24*30
        
        let weightNotes = WeightMOCK.shared.items.sorted {$0.date < $1.date}
//        let weightNotes = CoreDataManager.shared.getWeightNotes().sorted {$0.date < $1.date}
        
        
        
        var notesPerSelectedPeriod = [WeightNote]()

        for weightNote in weightNotes {
            if weightNote.date.timeIntervalSince(currentDate) < Double(month1InSeconds) {
                notesPerSelectedPeriod.append(weightNote)
            }
        }
        
        self.weightNotes = weightNotes
        self.notesPerSelectedPeriod = notesPerSelectedPeriod
    }
    
    
    let period = ChartPeriod.month1
    
    let manager = CoreDataManager.shared
    
    //    @State var weightItems = CoreDataManager.shared.getWeightNotes().sorted {$0.date < $1.date}
    
   
    var weightDifferenceBySelectedPeriodFormatted: String {
        if let lastNote = notesPerSelectedPeriod.last {
            if let firstNote = notesPerSelectedPeriod.first {
                let difference = lastNote.weight - firstNote.weight
                if difference > 0 {
                    return "+" + String(format: "%.1f", difference)
                } else {
                    return String(format: "%.1f", difference)
                }
            }
        }
        
        return ""
    }
    
    var minWeight: Float {
        
        var minWeight = weightNotes[0].weight
        
        for weightNote in weightNotes {
            if weightNote.weight < minWeight {
                minWeight = weightNote.weight
            }
        }
        
        return minWeight
    }
    
    var maxWeight: Float {
        
        var maxWeight = weightNotes[0].weight
        
        for weightNote in weightNotes {
            if weightNote.weight > maxWeight {
                maxWeight = weightNote.weight
            }
        }
        
        return maxWeight
    }
    
    var lastWeight: Float? {
        return weightNotes.last?.weight
    }
    
//    var measurementsInterval: Double? {
//        if let fisrtMesurement = weightNotes.first {
//            if let lastMesurement = weightNotes.last {
//                return abs(fisrtMesurement.date.timeIntervalSince(lastMesurement.date))
//            }
//        }
//        return nil
//    }
    
    
    
    
    func addWeightNote() {
        let newWeightNote = WeightNote(
            id: UUID().uuidString,
            weight: weight,
            date: dateOfNoteCreation
        )
        
        //добовляем запись в бд:
        manager.addWeightNote(note: newWeightNote)
        
        //обновляем массив локально:
        weightNotes.append(newWeightNote)
        weightNotes = weightNotes.sorted {$0.date < $1.date}
        
        dateOfNoteCreation = Date()
    }
    
    func deleteWeightNote(_ item: WeightNote) {
        
        //удаляем запись из бд
        manager.deleteWeightNote(byId: item.id)
        
        //удаляем из локального массива:
        for index in weightNotes.indices {
            if weightNotes[index].id == item.id {
                weightNotes.remove(at: index)
                return
            }
        }
    }
    
    func computeNotesPerSelectedPeriod(_ period: ChartPeriod) {
        
        print("Функция пересета запущена")
        
        var intervalInSeconds: Double = 0
        let currentDate = Date()
        
        switch period {
        case .week2:
            intervalInSeconds = 60*60*24*14
        case .month1:
            intervalInSeconds = 60*60*24*30
        case .month3:
            intervalInSeconds = 60*60*24*30*3
        case .month6:
            intervalInSeconds = 60*60*24*30*6
        case .year1:
            intervalInSeconds = 60*60*24*30*12
        case .all:
            intervalInSeconds = 228
        }
        
        notesPerSelectedPeriod = []
        
        for weightNote in weightNotes {
            print(currentDate.timeIntervalSince(weightNote.date))
            if currentDate.timeIntervalSince(weightNote.date) < intervalInSeconds {
                
                notesPerSelectedPeriod.append(weightNote)
            }
        }
        
        print("-----------------------")
        
        for weightNote in notesPerSelectedPeriod {
            print(currentDate.timeIntervalSince(weightNote.date))
        }
        
        
    }
}
