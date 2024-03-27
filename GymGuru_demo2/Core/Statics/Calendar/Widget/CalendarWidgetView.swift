//
//  CalendarWidgetView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.03.2024.
//

import SwiftUI

struct CalendarWidgetView: View {
    
    @ObservedObject var service: CalendarService
    
    init(service: CalendarService) {
        self.service = service
    }
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
            LazyVGrid(columns: columns, content: {
                ForEach(service.daysForColenderThisWeek) { day in
                    //CalendarDateView(day: day, selectedDay: service.selectedDate)
                    CalendarDateView(day: day)
                }
            })
            .padding(.horizontal)
        }
        .frame(width: 380, height: 80)
    }
}


