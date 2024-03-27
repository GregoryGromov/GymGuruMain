//
//  MuscleGroupView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 20.03.2024.
//

import SwiftUI

struct MuscleGroupView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let muscleGroup: String
    
    @StateObject var viewModel: AddProgrammViewModel
    
//    @State var thisMGExercises: [ExerciseItem] = []
    
    

    
    var body: some View {
        VStack {
            ForEach(viewModel.allExerciseItems.filter {$0.muscleGroup.contains(muscleGroup)}, id: \.self) { exercise in
                HStack {
                    Text(exercise.name)
                    Spacer()
                    if exercise.isSelected {
                        Image(systemName: "checkmark.circle")
                            .font(.title)
                    } else {
                        Image(systemName: "circle")
                            .font(.title)
                    }
                }
                .onTapGesture {
                    viewModel.selectExercise(exercise: exercise)
                }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Окей")
            }
        }
//        .onAppear {
//            thisMGExercises = viewModel.allExerciseItems.filter {$0.muscleGroup.contains(muscleGroup)}
//        }   
    }
}

