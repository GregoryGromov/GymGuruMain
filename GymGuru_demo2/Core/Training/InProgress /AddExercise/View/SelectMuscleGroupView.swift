//
//  AddExerciseView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//


import SwiftUI

struct SelectMuscleGroupView: View {
    
    @StateObject var viewModel: SelectMuscleGroupViewModel
    
    init(trainingViewModel: TrainingViewModel) {
        self._viewModel = StateObject(wrappedValue: SelectMuscleGroupViewModel(trainingViewModel: trainingViewModel))
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ForEach(viewModel.muscleGroups, id: \.self) { muscleGroup in
                NavigationLink {
                    if muscleGroup == "Your" {
//                        UsersExercisesView(muscleGroup: muscleGroup)
//                            .environmentObject(viewModel)
                        Text("Ваши упражнения")
                    } else {
                        SelectExercisesView(muscleGroup: muscleGroup)
                            .environmentObject(viewModel)
                    }
                    
                    
                } label: {
                    LinkLabel(title: muscleGroup)
                }
                
                
                
            }
            .navigationTitle("Select Muscle Groups")
            
            Button {
                //addSelectedExercisesToTraining()
                viewModel.addSelectedExercises() 
            } label: {
                Text("Add exercises to training")
//                Text("Add \(viewModel.amountOfSelectedExercises) exercises to training")
                    .foregroundStyle(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(red: 0, green: 0.92, blue: 0))
                        
                    )
             
            }
        }
        
    }
    
    //    private func addSelectedExercisesToTraining() {
    //        let selectedExercises = viewModel.returnSelectedExercises()
    //        dataManager.addSelectedExerciseToTraining(exercises: selectedExercises)
    //        dismiss()
    //    }
}


