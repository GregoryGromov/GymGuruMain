//
//  AddSetView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 01.04.2024.
//

//
//  AddSetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//

import SwiftUI
struct AddSetView2: View {
    
    
    let CONST_weightOfBody = 68.0
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var weight = ""
    @State private var amount = ""
    
    @State private var thisExerciseSets: [Set]?
    
    init(selectedExercise: Exercise) {
        self.selectedExercise = selectedExercise
        self.isBodyWeight = selectedExercise.isBodyweight
    }
    
    var selectedExercise: Exercise
    
    let isBodyWeight: Bool
    
    var body: some View {
        VStack {
            
            //header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
                Text(selectedExercise.name)
                    .offset(x: -10)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                
                
            }
            .padding()
            
            
            
            VStack {
                //existing sets of this exercise
                VStack {
                    if let thisExerciseSets = thisExerciseSets {
                        ScrollView {
                            ForEach(thisExerciseSets) { setItem in
                                if isBodyWeight {
                                    SetBWItemView(setItem: setItem)
                                        .padding(.vertical, 3)
                                } else {
                                    SetItemView(setItem: setItem)
                                        .padding(.vertical, 3)
                                        
                                }
                                

                            }
                        }
                    } else {
                        Text("Не вошли в иф")
                    }
                    
                }
                .padding(.horizontal, 35)
                .onAppear {
                    //без этого почему-то при поялвении не инициализируется thisExerciseSets
                    computeThisExerciseSets()
                }
                
                Spacer()
                
                //panel of adding new set
                HStack(alignment: .center) {
                    if isBodyWeight {
                        TextField("Amount", text: $amount)
                            .textFieldStyle(OvalTextFieldStyle2())
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 320, height: 40)
                            .padding(.horizontal, 15)
                    } else {
                        TextField("Weigth", text: $weight)
                            .textFieldStyle(OvalTextFieldStyle())
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 150, height: 40)
                            .padding(.horizontal, 15)
                        
                        Spacer()
                        
                        TextField("Amount", text: $amount)
                            .textFieldStyle(OvalTextFieldStyle())
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 150, height: 40)
                            .padding(.horizontal, 15)
                    }
                       
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
            }

            Button {
                if isBodyWeight {
                    let newSet = Set(
                        id: UUID().uuidString,
                        weight: Float(CONST_weightOfBody),
                        amount: Int(amount) ?? 0
                    )
                    viewModel.addSetToExercise(exerciseId: selectedExercise.id, setItem: newSet)
                } else {
                    let newSet = Set(
                        id: UUID().uuidString,
                        weight: Float(weight) ?? 0,
                        amount: Int(amount) ?? 0
                    )
                    viewModel.addSetToExercise(exerciseId: selectedExercise.id, setItem: newSet)
                }
                
                computeThisExerciseSets()
                weight = ""
                amount = ""
                viewModel.saveTraining()
            } label: {
                Text("Add set")
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [color1, color2]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                                .opacity(0.8)
                            )
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 38)
                    .padding(.bottom, 20)
            }
            Spacer()
        }
    }
    
    
    private func computeThisExerciseSets() {
        for i in 0...(viewModel.currentTraining.exercises.count - 1) {
            if viewModel.currentTraining.exercises[i].id == selectedExercise.id {
                self.thisExerciseSets = viewModel.currentTraining.exercises[i].sets
            }
        }
    }
    
}



