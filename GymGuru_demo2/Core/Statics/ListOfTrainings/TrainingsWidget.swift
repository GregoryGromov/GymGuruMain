//
//  TrainingsWidget.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 19.03.2024.
//

import SwiftUI

struct TrainingsWidget: View {
    
    @StateObject var viewModel = TrainingListViewModel()
    
    var body: some View {
//        VStack {
//            Text("Hello")
//        }
        ZStack {
            Text("Hello")
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
                
            VStack {
                ForEach(viewModel.trainings.prefix(3)) { training in
                    HStack {
                        Text("\(training.date.formatted(.dateTime.day().month()))")
                        Spacer()
                        Text("\(training.duration)")
                    }
                    .padding()
                }
            }
        }
        .frame(width: 180, height: 180)
    }
}

#Preview {
    TrainingsWidget()
        .preferredColorScheme(.dark)
}
