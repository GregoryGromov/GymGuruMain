//
//  MainTrainingPage.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 29.03.2024.
//

import SwiftUI

struct MainTrainingPage: View {
    
    @State var changeTimeset = false
    
    @State var timerIsRinging = false
    
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var timerInProgress = false
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    @State var timePeriod1 = 120
    @State var time = 120
    
    @State var persent = 10.0
    
    var body: some View {
        VStack {
            
            //main widget
            
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
                            Text("38:14")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                            
                            Button {
                                print("Завершить тренировку")
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
                .padding(.horizontal, 10)
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
                            Text("38:14")
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
                .padding(.horizontal, 10)
            }
            
            
            
            //activated timer
            
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
                            Text("\(time)")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading, 22)
                                .padding(.trailing, 16)
                                .frame(width: 100)
                            
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
                                    //                                .clipShape(RoundedRectangle(cornerRadius: 10)
                                    //                                    .frame(width: 160, height: 15))
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
                .padding(.horizontal, 10)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.systemGray5))
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 70)
                    
                    HStack {
                        TimeButtonView(amountOfMins: 0.04, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        TimeButtonView(amountOfMins: 3, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        TimeButtonView(amountOfMins: 5, timePeriod1: $timePeriod1, time: $time, timerInProgress: $timerInProgress)
                        
                        
                        
                        
                        Button {
                            changeTimeset = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray3))
                                
                                Image(systemName: "pencil")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                
                            }
                            .frame(width: 75, height: 38)
                        }
                        
                        
                    }
                }
                .padding(.horizontal, 10)
            }
            
           
            
            
            
            
            
            
            
                
            
            Spacer()
        }
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
    
    
}

#Preview {
    MainTrainingPage()
        .preferredColorScheme(.dark)
}
