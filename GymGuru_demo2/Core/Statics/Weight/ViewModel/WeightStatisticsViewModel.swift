import Foundation

class WeightStatisticsViewModel: ObservableObject {
    
    @Published var showListOfItems = true
    @Published var showDeletingAlert = false
    @Published var showAddWeightView = false
    
    @Published var dateOfNoteCreation = Date.now
    @Published var deletingItem: WeightNote? = nil
    @Published var weight: Float = 0
    
    
    
    @Published var weightNotesPerSelectedPeriod: [WeightNote]
    @Published var weightNotes: [WeightNote]
    @Published var availableTimePeriods: [TimePeriod]
    var selectedPeriod: TimePeriod
    var isShowingAllNotes = false
    
    
    init() {
        let allChartItems = WeightMOCK.shared.items.sorted {$0.date > $1.date}
        
//      let allChartItems = CoreDataManager.shared.getWeightNotes().sorted {$0.date < $1.date}
        
        
        self.weightNotes = allChartItems
        
        let chartItemsPerTimePeriod = allChartItems.filter { abs($0.date.timeIntervalSince(Date())) < Double(TimePeriod.values[1].seconds)}
        self.weightNotesPerSelectedPeriod = chartItemsPerTimePeriod
        self.selectedPeriod = TimePeriod.values[1]
        
        if let lastItem = allChartItems.last {
            if let firstItem = allChartItems.first {
                let secondsRange = Int(abs(firstItem.date.timeIntervalSince(lastItem.date)))
                
                var availableTimePeriods = [TimePeriod]()
                for timePeriod in TimePeriod.values {
                    if timePeriod.seconds < secondsRange {
                        availableTimePeriods.append(timePeriod)
                    } else {
                        break
                    }
                }
                
                self.availableTimePeriods = availableTimePeriods
                return
            }
        }
        self.availableTimePeriods = []
    }
    
    
    let manager = CoreDataManager.shared
        
   
    var weightDifferenceBySelectedPeriodFormatted: String {
        if let lastNote = weightNotesPerSelectedPeriod.last {
            if let firstNote = weightNotesPerSelectedPeriod.first {
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
        
        if isShowingAllNotes {
            weightNotesPerSelectedPeriod = weightNotes
        } else {
            computeChartItems(selectedPeriod: selectedPeriod)
        }
        
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
    
    func computeChartItems(selectedPeriod: TimePeriod) {
        var chartItems = [WeightNote]()
        for chartItem in weightNotes {
            if abs(chartItem.date.timeIntervalSince(Date())) < Double(selectedPeriod.seconds) {
                chartItems.append(chartItem)
            }
        }
        weightNotesPerSelectedPeriod = chartItems
    }
    
    func showAllChartItems() {
        weightNotesPerSelectedPeriod = weightNotes
    }
}
