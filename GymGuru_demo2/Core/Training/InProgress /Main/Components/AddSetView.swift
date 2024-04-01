//
//  AddSetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//

import SwiftUI



struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .padding(.leading, 32)
        
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(.systemGray2))
            )
    }
}

struct AddSetView: View {
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var weight = ""
    @State private var amount = ""
    
    @State private var thisExerciseSets: [Set]?
    
    init(selectedExercise: Exercise) {
        self.selectedExercise = selectedExercise
    }
    
    var selectedExercise: Exercise
    
    var body: some View {
        VStack {
            
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
            Spacer()
            
            VStack {
                if let thisExerciseSets = thisExerciseSets {
                    ForEach(thisExerciseSets) { setItem in
                        SetItemView(setItem: setItem)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 48)
                    }
                } else {
                    Text("Не вошли в иф")
                }
                
            }
            .onAppear {
                //без этого почему-то при поялвении не инициализируется thisExerciseSets
                computeThisExerciseSets()
            }
            
            
            HStack {
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
//                    .overlay {
//                        if weight.isEmpty {
//                            Text("Weight")
//                                .fontWeight(.bold)
//                        }
//                    }
            }
            .padding(.horizontal, 34)
            .padding(.top, 30)
            Button {
                let newSet = Set(id: UUID().uuidString, weight: Float(weight) ?? 0, amount: Int(amount) ?? 0)
                viewModel.addSetToExercise(exerciseId: selectedExercise.id, setItem: newSet)
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
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.black)
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 48)
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

