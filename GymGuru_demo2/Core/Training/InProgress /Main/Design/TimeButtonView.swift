//
//  TimeButtonView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 30.03.2024.
//

import SwiftUI

struct TimeButtonView: View {
    
    let amountOfMins: Float
    
    @Binding var timePeriod1: Int
    @Binding var time: Int
    @Binding var timerInProgress: Bool
    
    
    var body: some View {
        Button {
            timePeriod1 = Int(60 * amountOfMins)
            time = Int(60 * amountOfMins)
            withAnimation {
                timerInProgress = true
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray3))
                    
                
                Text("\(amountOfMins) min")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .frame(width: 75, height: 38)
        }
        .padding(.trailing, 5)
      
    }
}


