//
//  DateForCalendar.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 16.03.2024.
//

import SwiftUI

struct CalendarSelectedDateView: View {
    
    let day: DayForCalendar

    let minHeight: CGFloat = 40
    
    let calendar = Calendar.current
    
    var body: some View {
        
        if Date.now.startOfDay == day.date.startOfDay {
            Text("\(calendar.component(.day, from: day.date))")
                .fontWeight(.bold )
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .background(
                    Circle()
                        .foregroundStyle(.red.opacity(0.7))
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4)
                        )
                )
        } else if day.trainings.count > 0 {
            Text("\(calendar.component(.day, from: day.date))")
                .fontWeight(.bold )
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .background(
                    Circle()
                        .foregroundStyle(.green.opacity(0.7))
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4)
                        )
                )
        } else {
            Text("\(calendar.component(.day, from: day.date))")
                .fontWeight(.bold )
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .background(
                    Circle()
                        .foregroundStyle(.blue.opacity(0.7))
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4)
                        )
                )
        }
    }
}


