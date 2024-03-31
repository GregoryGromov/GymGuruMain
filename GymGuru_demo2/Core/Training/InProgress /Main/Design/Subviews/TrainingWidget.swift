//
//  TrainingWidget.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 31.03.2024.
//

import SwiftUI
       
struct TrainingWidget: View {
    
    @EnvironmentObject var viewModel: TrainingViewModel
    @Binding var timerInProgress: Bool
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    var body: some View {
        VStack {
            if timerInProgress {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.systemGray5))
                        .frame(height: 80)

                    HStack {
                        HStack(spacing: 16) {
                            Image(systemName: "timer")
                                .font(.largeTitle)
                                .foregroundStyle(Color(.systemGray2))
                            Text("3:14")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                            
                            Button {
                                viewModel.finishTraining()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray3))
                                    
                                    Text("завершить")
                                        .foregroundStyle(Color(.systemGray))
                                        .padding(7)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                }
                                .frame(width: 140, height: 30)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color1, color2]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                            .opacity(0.8)
                        )
                        .frame(height: 80)
                    
                    
                    HStack {
                        HStack(spacing: 16) {
                            Image(systemName: "timer")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            Text("3:14")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button {
                                print("Завершить тренировку")
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20).fill(.white)
                                        .opacity(0.3)
                                    
                                    Text("завершить")
                                        .foregroundStyle(.white)
                                        .padding(7)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                }
                                
                                .frame(width: 140, height: 30)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

