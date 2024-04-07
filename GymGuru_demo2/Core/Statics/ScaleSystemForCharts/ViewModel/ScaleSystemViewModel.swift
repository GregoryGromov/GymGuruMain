import Foundation

class ScaleSystemViewModel: ObservableObject {
    
    @Published var chartItemsPerSelectedPeriod: [ChartItem]
    @Published var availableTimePeriods: [TimePeriod]
    
    var allChartItems: [ChartItem]
    
    init() {
        let allChartItems = ChartTestData().chartItems.sorted {$0.date > $1.date}
        self.allChartItems = allChartItems
        
        let chartItemsPerTimePeriod = allChartItems.filter { abs($0.date.timeIntervalSince(Date())) < Double(TimePeriod.values[1].seconds)}
        self.chartItemsPerSelectedPeriod = chartItemsPerTimePeriod
        
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
    
    func computeChartItems(selectedPeriod: TimePeriod) {
        var chartItems = [ChartItem]()
        for chartItem in allChartItems {
            if abs(chartItem.date.timeIntervalSince(Date())) < Double(selectedPeriod.seconds) {
                chartItems.append(chartItem)
            } else {
                chartItemsPerSelectedPeriod = chartItems
                return
            }
        }
    }
    
    func showAllChartItems() {
        chartItemsPerSelectedPeriod = allChartItems
    }
}
