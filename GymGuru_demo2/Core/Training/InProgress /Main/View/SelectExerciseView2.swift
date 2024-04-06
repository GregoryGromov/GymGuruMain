//
//  SelectExerciseView2.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 01.04.2024.
//

import SwiftUI


struct SelectExerciseView2: View {
    
    @Environment(\.dismiss) var dismiss
    
    let muscleGroup: String
    
    @StateObject var viewModel: AddExerciseViewModel2
    
    
    var body: some View {
        VStack {
            ForEach(viewModel.allExerciseItems.filter {$0.muscleGroup.contains(muscleGroup)}, id: \.self) { exercise in
                HStack {
                    Text(exercise.name)
                    Spacer()
                    
                    if let _ = exercise.previouslySelected {
                        Image(systemName: "checkmark.circle")
                            .font(.title)
                            .opacity(0.5)
                    } else if exercise.isSelected {
                        Image(systemName: "checkmark.circle")
                            .font(.title)
                    } else {
                        Image(systemName: "circle")
                            .font(.title)
                    }
                }
                .onTapGesture {
                    viewModel.switchExerciseItemSelection(exercise: exercise)
                }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Окей")
            }
        }
    }
}
