////
////  ProgramsView.swift
////  GymGuru_demo2
////
////  Created by Григорий Громов on 27.03.2024.
////
//
//import SwiftUI
//
//struct ProgramsView: View {
//    
//    @StateObject var viewModel = ProgramsViewModel()
//    
//    var body: some View {
//        VStack {
//            if viewModel.programs.isEmpty {
//                Text("У Вас не добавлено ни одной программы")
//            } else {
//                VStack {
//                    ForEach(viewModel.programs, id: \.self) { program in
//                        VStack {
//                            HStack {
//                                Text(program.name)
//                                Spacer()
//                                Text("\(program.exercises.count)")
//                            }
//                            .padding()
//                            .background(
//                                viewModel.selectedProgramId == program.id
//                                ? Color(.systemGray2)
//                                : Color(.systemGray6)
//                            )
//                            .onTapGesture {
//                                viewModel.selectedProgramId = program.id
//                            }
//                            Divider()
//                        }
//                        
//                    }
//                }
//            }
//            
//            Button {
//                viewModel.showAddProgramView = true
//            } label: {
//                Text("Добавить программу")
//            }
//        }
//        .onAppear {
//            print("Я тут")
//        }
//        .sheet(isPresented: $viewModel.showAddProgramView) {
//            AddProgramView(programVM: viewModel)
//        }
//    }
//}
//
//
