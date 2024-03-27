//
//  MenuView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 12.03.2024.
//

import SwiftUI

struct MenuView: View {
    
    @State var showExerciseStatisticsView = false
    @State var showCalendarView = false
    @State var showWeightView = false
    
    @StateObject var exerciseStatisticsService = ExerciseStatisticsService()
    //@StateObject var calendarService = CalendarService()
    
    var body: some View {
        VStack {
            
            ExerciseWidget(service: exerciseStatisticsService)
                .onTapGesture {
                    showExerciseStatisticsView = true
                }
                .fullScreenCover(isPresented: $showExerciseStatisticsView) {
                    ExerciseMenuView(service: exerciseStatisticsService)
                }
                .padding(.vertical, 5)
            
            CalendarWidgetView(service: CalendarService())
                .onTapGesture {
                    showCalendarView = true
                }
                .fullScreenCover(isPresented: $showCalendarView) {
                    CalendarView(service: CalendarService())
                }
            
            HStack {
                WeightWidget()
                    .onTapGesture {
                        showWeightView = true
                    }
                    .fullScreenCover(isPresented: $showWeightView) {
                        WeightStatisticsView()
                    }
                TrainingsWidget()
                Spacer()
            }
            .padding()
                
            Spacer()
        }
    }
}


#Preview {
    MenuView()
        .preferredColorScheme(.dark)
}
