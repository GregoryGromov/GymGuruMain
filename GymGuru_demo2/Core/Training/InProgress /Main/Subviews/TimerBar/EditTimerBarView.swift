//
//  EditTimerBarView.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 02.04.2024.
//

import SwiftUI

struct EditTimerBarView: View {

    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: TimerBarViewModel
    
    @State var newTimeValue = 180

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.timeValues.filter {$0.isFavourite}) { timeValue in
                    HStack {
                        Text(viewModel.convertSecondsToMins(timeValue.seconds))
                        Spacer()
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            withAnimation {
                                viewModel.switchIsFavourite(timeValue)
                            }
                        } label: {
                            Label("Unlike", systemImage: "heart.slash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
            
            List {
                ForEach(viewModel.timeValues.filter {!$0.isFavourite}) { timeValue in
                    HStack {
                        Text(viewModel.convertSecondsToMins(timeValue.seconds))
                        Spacer()
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            withAnimation {
                                viewModel.addToFavourite(timeValue)
                            }
                            
                        } label: {
                            Label("Like", systemImage: "heart")
                        }
                        .tint(.indigo)
                        
                        Button() {
                            withAnimation {
                                viewModel.deleteTimeValue(timeValue)
                            }
                            
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }  
            
            Spacer()
            
            VStack {
                HStack {
                    Button {
                        newTimeValue -= 30
                    } label: {
                        Image(systemName: "minus")
                    }
                    
                    Text(viewModel.convertSecondsToMins(newTimeValue))
                        .frame(width: 90)
                    
                    Button {
                        newTimeValue += 30
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                Button {
                    
                    viewModel.createNewTimeValue(seconds: newTimeValue)
                } label: {
                    Text("Добавить")
                }
            }
        }
    }
}


