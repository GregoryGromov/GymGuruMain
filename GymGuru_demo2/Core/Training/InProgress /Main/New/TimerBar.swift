//
//  TimerBar.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 31.03.2024.
//

import SwiftUI

struct TimerBar: View {
    
    @Binding var timerInProgress: Bool
    @Binding var timerIsRinging: Bool
    @Binding var timePeriod1: Int
    @Binding var time: Int
    @Binding var showChangeTimesetView: Bool
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    
    
    var body: some View {
        VStack {
            if timerInProgress {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color1, color2]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                            .opacity(0.8)
                        )
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 70)
                    
                    
                    
                    
                    HStack {
                        
                        if timerIsRinging {
                            Text("Время вышло")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading, 44)
                        } else {
                            Text("\(formatSecondsToMinutesAndSeconds(seconds: time))")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading, 10)
                                .frame(width: 105)
                            
                            Spacer()
                            
                            
                            ZStack {
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 160, height: 15).opacity(0.3)
                                    Spacer()
                                }
                                
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 160 * CGFloat((Float(time) / Float(timePeriod1))), height: 15).opacity(1)
                                    Spacer()
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                timerInProgress = false
                            }
                            
                            time = timePeriod1
                            timerIsRinging = false
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.white))
                                    .opacity(0.4)
                                
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                                    .padding(7)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                            }
                            .frame(width: 60, height: 30)
                            .padding(.trailing, 18)
                        }
                    }
                }
                
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.systemGray6))
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 70)
                    
                    HStack {
                        TimeButtonView(amountOfSeconds: 3, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        TimeButtonView(amountOfSeconds: 150, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        TimeButtonView(amountOfSeconds: 300, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        
                        
                        
                        Button {
                            showChangeTimesetView = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray4))
                                
                                Image(systemName: "pencil")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                
                            }
                            .frame(width: 75, height: 38)
                        }
                        
                        
                    }
                }
        }
        

        }
    }
    
    private func formatSecondsToMinutesAndSeconds(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        if remainingSeconds > 9 {
            return "\(minutes):\(remainingSeconds)"
        } else {
            return "\(minutes):0\(remainingSeconds)"
        }
    }
}

