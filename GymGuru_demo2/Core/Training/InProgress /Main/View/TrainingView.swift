//
//  TrainingView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct TrainingView: View {
    
    @StateObject var viewModel: TrainingViewModel
    
    
    
    @Namespace private var animation
    
    @State var timerInProgress = false
    @State var showChangeTimesetView = false
    @State var timerIsRinging = false
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var timePeriod1 = 120
    @State var time = 120
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    
    
    init(router: RouterViewModel) {
        self._viewModel = StateObject(wrappedValue: TrainingViewModel(router: router))
    }
    
    var body: some View {
        VStack {
            TrainingWidget(timerInProgress: $timerInProgress)
                .environmentObject(viewModel)
            
            TimerBar(timerInProgress: $timerInProgress,
                     timerIsRinging: $timerIsRinging,
                     timePeriod1: $timePeriod1,
                     time: $time,
                     showChangeTimesetView: $showChangeTimesetView)
            
            AddExerciseBar()
                .environmentObject(viewModel)
            
            ScrollView {
                ForEach(viewModel.currentTraining.exercises, id: \.self) { exercise in
                    VStack{
                        HStack {
                            Text(exercise.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            PurpleCircles(amount: exercise.sets.count, isActive: $timerInProgress)
                            Image(systemName: "chevron.up")
                                .rotationEffect(.degrees(exercise.isFolded ? 180 : 0))
                                .fontWeight(.bold)
                                .frame(width: 16)
                                .padding(.leading, 12)
                                .onTapGesture {
                                    withAnimation() {
                                        foldExerciseInfo(byID: exercise.id)
                                    }
                                    
                                }
                        }
                        .padding(.horizontal, 12)
                        
                        if exercise.isFolded {
                            EmptyView()
                                .matchedGeometryEffect(id: "exerciseInfo" + exercise.id, in: animation)
                        } else {
                            VStack {
                                ForEach(exercise.sets, id: \.self) { setItem in
                                    SetItemView(setItem: setItem)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .matchedGeometryEffect(id: "exerciseInfo" + exercise.id, in: animation)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(.systemGray5))
                            .padding(.horizontal, 1)
                        
                    )
                    .onTapGesture {
                        viewModel.selectedExercie = exercise
                        viewModel.showAddSetView.toggle()
                    }
                }
                .fullScreenCover(isPresented: $viewModel.showAddExerciseView) {
                    SelectMuscleGroupView2(trainingViewModel: viewModel)
                }
                
                
                
                
                
            }
            
            .sheet(isPresented: $viewModel.showAddSetView, content: {
                if let selectedExercie = viewModel.selectedExercie {
                        AddSetView2(selectedExercise: selectedExercie)
                            .environmentObject(viewModel)                    
                } else {
                    Text("Ошибка 1")
                }
            })
            
            
        }
        .padding(.horizontal, 10)
        .onReceive(self.timer) { _ in
            if timerInProgress {
                if time > 0 {
                    withAnimation {
                        time  -= 1
                    }
                } else {
                    timerIsRinging = true
                    print("Время вышло")
                }
                
            }
        }
    }
    
    func foldExerciseInfo(byID id: String) {
        for index in viewModel.currentTraining.exercises.indices {
            if viewModel.currentTraining.exercises[index].id == id {
                viewModel.currentTraining.exercises[index].isFolded.toggle()
                return
            }
        }
    }
    
    //    func delete(at offsets: IndexSet) {
    //        viewModel.currentTraining.exercises.remove(atOffsets: offsets)
    //    }
}


