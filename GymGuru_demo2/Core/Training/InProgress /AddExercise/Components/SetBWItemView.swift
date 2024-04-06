//
//  SetBWItemView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 01.04.2024.
//

import SwiftUI

struct SetBWItemView: View {
    
    let setItem: Set
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(.systemGray3))
                    .frame(width: 320, height: 40)
                
                Text("\(setItem.amount)")
            }
            
            
        }
        .font(.title3)
        .fontWeight(.bold)
    }
    
    
}
