//
//  LinkLabel.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 14.02.2024.
//

import SwiftUI

struct LinkLabel: View {
    
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.title)
            }
            .padding()
            Divider()
        }
    }
}

