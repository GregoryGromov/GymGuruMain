//
//  TimeButtonView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 30.03.2024.
//

import SwiftUI

struct TimeButtonView: View {
    
    let amountOfSeconds: Int
    
    @Binding var timePeriod1: Int
    @Binding var time: Int
    @Binding var timerInProgress: Bool
    
    var amountOfMins: String {
        if amountOfSeconds % 30 == 0 {
            let amountOfHalfMinutes = amountOfSeconds / 30
            if amountOfHalfMinutes % 2 == 0 {
                return "\(amountOfHalfMinutes / 2)"
            } else {
                return "\(amountOfHalfMinutes / 2).5"
            }
        } else {
            return "228"
        }
    }
    
    
    var body: some View {
        Button {
            timePeriod1 = amountOfSeconds
            time = amountOfSeconds
            withAnimation(.easeIn) {
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


