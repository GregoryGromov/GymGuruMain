//
//  WeightStatisticsView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 18.03.2024.
//

import SwiftUI
import Charts

struct WeightStatisticsView: View {
    
    @StateObject var viewModel = WeightStatisticsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                    HStack {
                        if let lastWeight = viewModel.lastWeight {
                            Text("\(String(format: "%.1f", lastWeight)) kg")
                                .font(.title2)
                                .padding(.leading, 20)
                                .fontWeight(.bold)
                            Spacer()
                            
                            VStack {
                                Text(viewModel.weightDifferenceBySelectedPeriodFormatted + " kg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("за меяц")
                                    .font(.caption)
                            }
                            .foregroundStyle(Color(.systemGray3))
                        }
                    }
                    .padding()
                }
                .frame(height: 80)
                
                
                
                //select chart time period bar
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.availableTimePeriods) { timePeriod in
                            Button {
                                withAnimation {
                                    viewModel.computeChartItems(selectedPeriod: timePeriod)
                                    viewModel.selectedPeriod = timePeriod
                                    viewModel.isShowingAllNotes = false
                                }
                            } label: {
                                Text(timePeriod.name)
                            }
                        }
                        .padding(.horizontal)
                        Button {
                            withAnimation {
                                viewModel.showAllChartItems()
                                viewModel.isShowingAllNotes = true
                            }
                        } label: {
                            Text("all")
                        }
                    }
                    
                }
                
                //chart
                if viewModel.weightNotes.count > 1 {
                    
                    Chart {
                        ForEach(viewModel.weightNotesPerSelectedPeriod) { point in
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
                    .frame(width:320, height: viewModel.showListOfItems ? 180 : 300)
                    .chartYScale(domain: (Int(viewModel.minWeight)-1)...(Int(viewModel.maxWeight)+1))
                    
                }
                
                
                
                
                
                
                
                
                
                //list of notes
                VStack {
                    List {
                        HStack {
                            Text("ЗАПИСИ")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                            Spacer()
                            Button {
                                withAnimation {
                                    viewModel.showListOfItems.toggle()
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .rotationEffect(viewModel.showListOfItems ? .degrees(90) : .degrees(0))
                            }
                        }
                        
                        if viewModel.showListOfItems {
                                                        
                            ForEach(viewModel.weightNotes) { item in
                                HStack {
                                    Text("\(item.date.formatted(.dateTime.day().month()))")
                                    Spacer()
                                    Text("\(String(format: "%.1f", item.weight))kg")
                                        .frame(width: 100, alignment: .trailing)
                                }
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        //deleteWeightItem(byId: item.id)
                                        viewModel.deletingItem = item
                                        viewModel.showDeletingAlert = true
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
                
                //add new note button
                Button {
                    if let lastWeightNote = viewModel.weightNotes.last {
                        viewModel.weight = lastWeightNote.weight
                    }
                    viewModel.showAddWeightView = true
                } label: {
                            Text("Добавить")
                                .font(.custom("Avenir-Heavy", size: 20))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                        
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: .init(colors: [Color("orange1"), Color("orange2")]),
                                startPoint: .init(x: -0.33, y: -0.33),
                                endPoint: .init(x: 0.66, y: 0.66)
                            ))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .buttonStyle(PlainButtonStyle())
                    
                    
                }
                
                
            }.sheet(isPresented: $viewModel.showAddWeightView) {
                addNewWeightView
                    .presentationDetents([.height(200)])
            }
            
            .onAppear {
                if let lastWeightNote = viewModel.weightNotes.last {
                    viewModel.weight = lastWeightNote.weight
                }
            }
            
            .alert(isPresented: $viewModel.showDeletingAlert) {
                Alert(
                    title: Text("Удалить запись о весе?"),
                    message: Text("Это действие невозможно отменить"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = viewModel.deletingItem {
                            viewModel.deleteWeightNote(item)
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
                DatePicker("", selection: $viewModel.dateOfNoteCreation, displayedComponents: .date)
                    .offset(x: -60)
                Spacer()
            }
            .padding(.bottom)
        
            HStack {
                Button {
                    viewModel.weight -= 0.1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                }
                Spacer()
                
                Text(String(format: "%.1f", viewModel.weight))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 100, alignment: .center)
                
                Spacer()
                
                Button {
                    viewModel.weight += 0.1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                }
                
                
                
                
                
                
                
            }
            
            Button {
                viewModel.addWeightNote()
            } label: {
                Text("Добавить измерение")
            }
        }
        .onAppear {
            if let lastWeightNote = viewModel.weightNotes.last {
                viewModel.weight = lastWeightNote.weight
            }
        }
        .padding(.horizontal, 70)
    }
}

#Preview {
    WeightStatisticsView()
        .preferredColorScheme(.dark)
}
