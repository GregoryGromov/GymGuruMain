//
//  ControlWidgetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct TrainingStartView: View {
    
    //%1 как лучше сделать этот момент: данные viewModel в качестве внешнего объекта нужна только для того, чтобы запустить тренировку. Минус этой реализации состоит в том, что мы в отдельный вью передаем вью модель другого вью.
    
    //Альтернативой служат реализации либо через Combine, чтобы RouterViewModel слушала какое-нибудь своство в TrainingViewModel, либо чтобы мы получали @EnvironmentObject и по хитрому передавали его в TrainingViewModel.
    
    //Но и та, и та реализации выглядет чересчур надуманными
    
    
    //Мое предложение, сделать так:
    //    @EnvironmentObject var router: RouterViewModel
    
    let router: RouterViewModel
    @StateObject var viewModel: TrainingStartViewModel
    
    init(router: RouterViewModel) {
        self._viewModel = StateObject(wrappedValue: TrainingStartViewModel(router: router))
        self.router = router
    }
    
    var body: some View {
        VStack {
            Button {
                
                viewModel.startTraining()
            } label: {
                Text("Начать")
            }
            
            HStack {
                Text("Choose program")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            
            
            VStack {
                if viewModel.programs.isEmpty {
                    Text("У Вас не добавлено ни одной программы")
                } else {
                    VStack {
                        ForEach(viewModel.programs, id: \.self) { program in
                            VStack {
                                HStack {
                                    Text(program.name)
                                    Spacer()
                                    Text("\(program.exercises.count)")
                                }
                                .padding()
                                .background(
                                    viewModel.selectedProgramId == program.id
                                    ? Color(.systemGray2)
                                    : Color(.systemGray6)
                                )
                                .onTapGesture {
                                    viewModel.selectedProgramId = program.id
                                }
                                Divider()
                            }
                            
                        }
                    }
                }
                
                Button {
                    viewModel.showAddProgramView = true
                } label: {
                    Text("Добавить программу")
                }
            }
            .onAppear {
                print("Я тут")
            }
            .sheet(isPresented: $viewModel.showAddProgramView) {
                AddProgramView(programVM: viewModel)
            }
            
            
        }
        
    }
}

