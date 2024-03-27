//
//  WeightStatisticsView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 18.03.2024.
//

import SwiftUI
import Charts

struct WeightStatisticsView: View {
    

    let manager = CoreDataManager.shared
    
    //@State var weightItems = WeightMOCK.shared.items.sorted {$0.date < $1.date}
    
    @State var weightItems = CoreDataManager.shared.getWeightNotes().sorted {$0.date < $1.date}
    
    
    @State var showListOfItems = false
    @State var showDeletingAlert = false
    
    
    
    
    @State private var dateOfNoteCreation = Date.now
    
    var minWeight: Float {
        
        var minWeight = weightItems[0].weight
        
        for weightItem in weightItems {
            if weightItem.weight < minWeight {
                minWeight = weightItem.weight
            }
        }
        
        return minWeight
    }
    var maxWeight: Float {
        
        var maxWeight = weightItems[0].weight
        
        for weightItem in weightItems {
            if weightItem.weight > maxWeight {
                maxWeight = weightItem.weight
            }
        }
        
        return maxWeight
    }
    
    @State var deletingItem: WeightItem? = nil
    
    @State var weight: Float = 0
    
    @State var showAddWeightView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if weightItems.count > 1 {
                    ZStack {
            //            RoundedRectangle(cornerRadius: 25)
            //                .fill(Color(.systemGray6))
                        Chart {
                            ForEach(weightItems) { point in
                                LineMark(
                                    x: .value("Date", point.date),
                                    y: .value("MaxWeight", point.weight)
                                )
                            }
                            .foregroundStyle(.orange)
                            .lineStyle(StrokeStyle(lineWidth: 5))
                            .interpolationMethod(.catmullRom)
                            .symbol() {
                                Circle()
                                    .fill(.orange)
                                    .frame(width: 10, height: 10)
                            }
                          
                            
            //                ForEach(weightItems) { point in
            //                    AreaMark(
            //                        x: .value("Date", point.date),
            //                        y: .value("MaxWeight", point.weight)
            //                    )
            //
            //
            //                }
            //                .foregroundStyle(Colors.shared.linearGradientOrange2)
            //                .interpolationMethod(.catmullRom)
                        }
                        .frame(width:320, height: 300)
                        .chartYScale(domain: (Int(minWeight)-1)...(Int(maxWeight)+1))
                    }
                }
                
                
                
                Button {
                    if let lastWeightItem = weightItems.last {
                        weight = lastWeightItem.weight
                    }
                    showAddWeightView = true
                } label: {
                    Text("Добавить вес")
                }
                
                
                Button {
                    withAnimation {
                        showListOfItems.toggle()
                    }
                } label: {
                    Text("Показать ваши записи")
                }
                
                
                
                
                if showListOfItems {
                    VStack {
                        List {
                            ForEach(weightItems.sorted {$0.date > $1.date}) { item in
                                HStack {
                                    Text("\(item.date.formatted(.dateTime.day().month()))")
                                    Spacer()
                                    Text("\(String(format: "%.1f", item.weight))kg")
                                        .frame(width: 100, alignment: .center)
                                }
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        //deleteWeightItem(byId: item.id)
                                        deletingItem = item
                                        showDeletingAlert = true
                                    } label: {
                                        Label("Mute", systemImage: "trash.fill")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        
                    }
                }
                
                
                
                Spacer()
                
            }.sheet(isPresented: $showAddWeightView) {
                addNewWeightView
                    .presentationDetents([.height(200)])
            }
            
            .onAppear {
                if let lastWeightItem = weightItems.last {
                    weight = lastWeightItem.weight
                }
            }
            
            .alert(isPresented: $showDeletingAlert) {
                        Alert(
                            title: Text("Удалить запись о весе?"),
                            message: Text("Это действие невозможно отменить"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let item = deletingItem {
                                    deleteWeightItem(item)
                                }
                                
                            },
                            secondaryButton: .cancel()
                        )
                    }
        }
    }
    
    
    var addNewWeightView: some View {
        VStack {
            
            HStack {
                Spacer()
//                if dateOfNoteCreation.startOfDay == Date().startOfDay {
//                    ZStack {
//                        HStack {
//                            Text("Сегодня")
//                                .font(.title2)
//                            Image(systemName: "chevron.down")
//                                .foregroundStyle(.orange)
//                                .fontWeight(.bold)
//                        }
//                        .allowsHitTesting(false)
//                        DatePicker("Please enter a time", selection: $dateOfNoteCreation, displayedComponents: .date).opacity(0.1)
//                    }
//                    
//                }
                DatePicker("", selection: $dateOfNoteCreation, displayedComponents: .date)
                    .offset(x: -60)
                
                
                Spacer()
            }
            .padding(.bottom)
        
            
            HStack {
                Button {
                    weight -= 0.1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                }
                Spacer()
                
                Text(String(format: "%.1f", weight))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 100, alignment: .center)
                
                Spacer()
                
                Button {
                    weight += 0.1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                }
            }
            
            Button {
                addNewWeight(weight, at: dateOfNoteCreation)
            } label: {
                Text("Добавить измерение")
            }
        }
        .onAppear {
            if let lastWeightItem = weightItems.last {
                weight = lastWeightItem.weight
            }
        }
        .padding(.horizontal, 70)
    }
    
    func addNewWeight(_ weight: Float, at date: Date) {
        let newWeightItem = WeightItem(
            id: UUID().uuidString,
            weight: weight,
            date: date
        )
        
        //добовляем запись в бд:
        manager.addWeightNote(note: newWeightItem)
        
        //обновляем массив локально:
        weightItems.append(newWeightItem)
        weightItems = weightItems.sorted {$0.date < $1.date}
        
        dateOfNoteCreation = Date()
    }
    
    func deleteWeightItem(_ item: WeightItem) {
        
        //удаляем запись из бд
        manager.deleteWeightNote(byId: item.id)
        
        //удаляем из локального массива:
        for index in 0...(weightItems.count-1) {
            if weightItems[index].id == item.id {
                weightItems.remove(at: index)
                return
            }
        }
    }
}

#Preview {
    WeightStatisticsView()
        .preferredColorScheme(.dark)
}
