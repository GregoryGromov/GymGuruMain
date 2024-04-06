//
//  SelectMuscleGroupView2.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 01.04.2024.
//

import SwiftUI

struct SelectMuscleGroupView2: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: AddExerciseViewModel2
    
    init(trainingViewModel: TrainingViewModel) {
        self._viewModel = StateObject(wrappedValue: AddExerciseViewModel2(trainingViewModel: trainingViewModel))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(viewModel.muscleGroups, id: \.self) { muscleGroup in
                    NavigationLink {
                        SelectExerciseView2(muscleGroup: muscleGroup, viewModel: viewModel)
                    } label: {
                        HStack {
                            Text(muscleGroup)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        
                        
                    }
                }
                
                Button {
                    viewModel.addNewExercisesToTraining()
                    dismiss()
                } label: {
                    Text("Добавить \(viewModel.bufferedExerciseItems.count)")
                }
            }
        }
        
    }
}

