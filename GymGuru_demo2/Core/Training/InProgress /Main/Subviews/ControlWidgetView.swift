//
//  ControlWidgetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color(.systemGray3))
                    .frame(height: 38)
            )
            .foregroundColor(Color(.systemGray))
    }
}


struct TimeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color(.systemGray3))
                    .frame(width: 75, height: 38)
            )
            .foregroundColor(Color(.systemGray))
    }
}

struct ControlWidgetView: View {
    
    //@EnvironmentObject var viewModel: TrainingViewModel
    
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var trainingDuration = 0
    @State var formattedDuration = ""
    //
    //    var amountOfExercises: Int {
    //        return viewModel.currentTraining.exercises.count
    //    }
    //
    //    var amountOfSets: Int {
    //        var setCounter = 0
    //        for exercise in viewModel.currentTraining.exercises {
    //            setCounter += exercise.sets.count
    //        }
    //        return setCounter
    //    }
    
    let columns = Array(repeating: GridItem(.flexible()), count: 1)
    
    
    
    var body: some View {
        
        
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(.systemGray5))
                HStack() {
                    
                    Image(systemName: "timer")
                        .font(.largeTitle)
                        .foregroundStyle(Color(.systemGray2))
                        .padding()
                    
                    
                    
                    Text("15:04")
                    
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    //                    .onReceive(self.timer) { time in
                    //                        trainingDuration  += 1
                    //                        formattedDuration = viewModel.secondsToTime(inSeconds: trainingDuration)
                    //                    }
                    
                    Spacer()
                    
                    
                    
                    Button("Завершить") {
                        //                    viewModel.finishTraining()
                    }
                    .buttonStyle(BlueButton())
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            
            HStack {
                Image(systemName: "hourglass.bottomhalf.filled")
                    .font(.largeTitle)
                    .padding(.trailing, 10)
                
                
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Text("1 min")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(Color(.systemGray3))
                                    .frame(width: 75, height: 38)
                            )
                            .foregroundColor(Color(.systemGray))
                    }
                    
                    Button {
                        
                    } label: {
                        Text("3 min")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(Color(.systemGray3))
                                    .frame(width: 75, height: 38)
                            )
                            .foregroundColor(Color(.systemGray))
                    }
                    
                    Button {
                        
                    } label: {
                        Text("5 min")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(Color(.systemGray3))
                                    .frame(width: 75, height: 38)
                            )
                            .foregroundColor(Color(.systemGray))
                    }
                    
                }
                .padding(.trailing, 4)
                    
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .fontWeight(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(Color(.systemGray3))
                                .frame(width: 75, height: 38)
                        )
                        .foregroundColor(Color(.systemGray))
                    
                }
                
                
                    
                    
                    
        
            }
            
            Spacer()
            
            
            
            
            
        }
        
        //        .onAppear {
        //            trainingDuration = viewModel.computeTrainingDuration()
        //        }
    }
}



#Preview {
    ControlWidgetView()
        .preferredColorScheme(.dark)
}
