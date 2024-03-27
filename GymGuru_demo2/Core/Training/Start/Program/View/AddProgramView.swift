//
//  AddProgramView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 19.03.2024.
//

import SwiftUI

struct AddProgramView: View {    
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: AddProgrammViewModel
    
    init(programVM: ProgramsViewModel) {
        self._viewModel = StateObject(wrappedValue: AddProgrammViewModel(motherViewModel: programVM))
    }

    
    
//        .background(
//            Circle()
//                .foregroundStyle(.blue.opacity(0.7))
//                .overlay(
//                    Circle().stroke(Color.white, lineWidth: 4)
//                )
//        )
    
    
    
    
    
    var body: some View {
        VStack {
            
            TextField("Название", text: $viewModel.programName)
                .foregroundColor(.white)
                .background(Color.gray).opacity(0.5)
                .padding()
            
            HStack {
                ForEach(viewModel.colors, id: \.self) { item in
                    if item == viewModel.selectedColor {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(item)
                            .background(
                                Circle()
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 10)
                                    )
                            )
                            .onTapGesture {
                                viewModel.selectedColor = item
                            }
                    } else {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(item)
                            .onTapGesture {
                                viewModel.selectedColor = item
                            }
                    }
                }
            }
            
            Text("В программе: ")
            ForEach(viewModel.addedExercises, id: \.self) { exercise in
                HStack {
                    Text(exercise.name)
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Button {
                            withAnimation {
                                viewModel.moveUp(exerciseItemName: exercise.name)
                            }
                        } label: {
                            Image(systemName: "chevron.up")
                        }
                        
                        Button {
                            withAnimation {
                                viewModel.moveDown(exerciseItemName: exercise.name)
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                    }
                    
                }
                .padding()
            }
            Button {
                viewModel.showAddExerciseView = true
                
            } label: {
                Text("Добавить")
            }
            
           
            
            Spacer()
            
            Button {
                viewModel.saveProgram()
                dismiss()
            } label: {
                Text("Сохранить тренировку")
            }
            
        }
        .fullScreenCover(isPresented: $viewModel.showAddExerciseView) {
            MuscleGroupSelectView(viewModel: viewModel)
        }
    }
}

