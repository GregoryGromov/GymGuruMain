//
//  SelectExercisesView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 21.12.2023.
//

import SwiftUI

struct SelectExercisesView: View {
    
    @StateObject var viewModel: SelectMuscleGroupViewModel
    @Environment(\.dismiss) var dismiss
    
    let muscleGroup: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
                Text(muscleGroup)
                    .offset(x: -10)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            ForEach(viewModel.exerciseItems.filter({ $0.muscleGroup.contains(muscleGroup)}), id: \.self)  { exercise in
                VStack{
                    HStack {
                        Text(exercise.name)
                            .padding()
                            .font(.title3)
                            .fontWeight(.bold)
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
                    .padding()
                    Divider()
                }
            }
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Выбрать")
                    .foregroundStyle(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(red: 0, green: 0.92, blue: 0))
                        
                    )
            }
        }
            .navigationBarTitle("Select exercise")
            .navigationBarHidden(true)
    }
}
