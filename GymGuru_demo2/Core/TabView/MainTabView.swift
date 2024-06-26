//
//  MainTabView.swift
//  InstagramTutorial
//
//  Created by Григорий Громов on 13.07.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 0
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            //StatisticsView()
            //TrainingsStatisticsView()
            MenuView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")

                        .font(.largeTitle)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [color1, color2]),
                                                  startPoint: .topLeading,
                                                  endPoint: .bottomTrailing))
                }.tag(0)
            
            RouterView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                }.tag(1)
        }
        .accentColor(.purpleForCircles)
    }
}


