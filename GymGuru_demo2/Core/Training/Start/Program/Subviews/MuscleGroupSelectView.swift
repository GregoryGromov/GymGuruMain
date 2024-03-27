//
//  MuscleGroupSelectView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 20.03.2024.
//

import SwiftUI

struct MuscleGroupSelectView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var muscleGroups = ["Chest", "Legs", "Back", "Arms", "Shoulders"]
    
    @StateObject var viewModel: AddProgrammViewModel
    
    
    var body: some View {
        NavigationStack {
            ForEach(muscleGroups, id: \.self) { muscleGroup in
                NavigationLink {
                    MuscleGroupView(muscleGroup: muscleGroup, viewModel: viewModel)
                } label: {
                    Text(muscleGroup)
                }
            }
            
            Button {
                viewModel.addNewExerciseItems()
                dismiss()
            } label: {
                Text("Добавить")
            }
        }
        
    }
}

