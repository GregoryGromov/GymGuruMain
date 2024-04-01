//
//  AddExerciseButton.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct AddExerciseBar: View {
    @EnvironmentObject var viewModel: TrainingViewModel
    
    var body: some View {
        HStack {
            Text("Упражнения")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            Button {
                viewModel.showAddExerciseView.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color(.systemGray))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}


