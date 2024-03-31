//
//  PurpleCircles.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 30.03.2024.
//

import SwiftUI

struct PurpleCircles: View {
    
    let amount: Int
    @Binding var isActive: Bool
    
    
    var body: some View {
        if amount < 5 && amount != 0 {
            ForEach(0...(amount - 1), id: \.self) { _ in
                Rectangle()
                .frame(width: 12, height: 12)
                .foregroundStyle(
                    isActive
                    ? Color(.systemGray2)
                    : Color("purpleForCircles")
                )
                .cornerRadius(10)
            }
        } else if amount != 0 {
            Text("\(amount)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(
                    isActive
                    ? Color(.systemGray2)
                    : Color("purpleForCircles")
                )
        }
    }
}

