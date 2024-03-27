import SwiftUI


struct CalendarView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var service: CalendarService
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    
    
    let calendar = Calendar.current
    
    
    
    

    //let timeString = dateFormatter.string(from: date)
   
  
    
    var body: some View {
        VStack {
            
            
            HStack {
                Button {
                    service.switchToPreviousMonth()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                }
                
                Spacer()
                Text("\(service.date.formatted(.dateTime.month())) \(service.date.formatted(.dateTime.year()))")
                    .fontWeight(.bold)
                Spacer()
                
                Button {
                    service.switchToNextMonth()
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                }
            }
            .font(.title)
            .padding()
            
            // Переключатель даты
//            LabeledContent("Date/Time") {
//                DatePicker("", selection: $service.date)
//            }
            
            // Первые буквы дней недели
            HStack {
                ForEach(service.daysOfWeek.indices, id: \.self) { index in
                    Text(service.daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Календарь
            LazyVGrid(columns: columns, content: {
                ForEach(service.daysForCalendar) { day in
                    if day.date.monthInt != service.date.monthInt {
                        if let selectedDate = service.selectedDate {
                            if day.date.startOfDay == selectedDate.startOfDay {
                                CalendarSelectedDateView(day: day).opacity(0.5)
                                    .onTapGesture {
                                        service.setSelectedDay(to: day.date)
                                        //service.reloadCalendarData()
                                        service.setSelectedDayTrainings(trainings: day.trainings)
                                    }
                            } else {
                                CalendarDateView(day: day).opacity(0.5)
                                    .onTapGesture {
                                        service.setSelectedDay(to: day.date)
                                        //service.reloadCalendarData()
                                        service.setSelectedDayTrainings(trainings: day.trainings)
                                    }
                            }
                        } else {
                            CalendarDateView(day: day).opacity(0.5)
                                .onTapGesture {
                                    service.setSelectedDay(to: day.date)
                                    //service.reloadCalendarData()
                                    service.setSelectedDayTrainings(trainings: day.trainings)
                                }
                        }
                    } else { //если это текущий месяц
                        if let selectedDate = service.selectedDate { //если какая-то дата выбрана
                            if day.date.startOfDay == selectedDate.startOfDay { //если она совпала с day.date
                                CalendarSelectedDateView(day: day)
                                    .onTapGesture {
                                        service.setSelectedDay(to: day.date)
                                        service.setSelectedDayTrainings(trainings: day.trainings)
                                    }
                            } else {
                                CalendarDateView(day: day)
                                    .onTapGesture {
                                        service.setSelectedDay(to: day.date)
                                        //service.reloadCalendarData()
                                        service.setSelectedDayTrainings(trainings: day.trainings)
                                    }
                            }
                        } else {
                            CalendarDateView(day: day)
                                .onTapGesture {
                                    service.setSelectedDay(to: day.date)
                                    //service.reloadCalendarData()
                                    service.setSelectedDayTrainings(trainings: day.trainings)
                                }
                        }
                        
                    }
                }
            })
            
            
            
            if let selectedDate = service.selectedDate {
                
                VStack {
                    HStack {
                        Text("\(selectedDate.formatted(.dateTime.month())) \(selectedDate.formatted(.dateTime.day()))")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    VStack {
                        if service.selectedDateTrainings.count > 0 {
                            ForEach(service.selectedDateTrainings, id: \.self) { training in
                                NavigationLink {
                                    Text("Training info")
                                } label: {
                                    HStack {
//                                        Text(service.getTimeAsString(from: training.date))
                                        Text(service.convertSecondsToDuration(seconds: training.duration))
                                        Spacer()
                                        
                                    }
                                }
                            }
                        } else {
                            Text("В выбранный день не было тренировок")
                        }
                        
                    }
                }
                .padding(.top, 20)
            }
            
            
            Spacer()
            
            Button("Закрыть") {
                dismiss()
            }
        }
        .padding()
        .onAppear {
            service.reloadCalendarData()
        }
        .onChange(of: service.date) {
            service.reloadCalendarData()
        }
        .onChange(of: service.selectedDate) {
            print("Поменялась")
        }
    }
}
