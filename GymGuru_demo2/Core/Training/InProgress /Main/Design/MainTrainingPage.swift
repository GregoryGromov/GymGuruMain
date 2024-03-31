import SwiftUI

struct MainTrainingPage: View {
    
    
    
    @Namespace private var animation
    
   
    
    
    @State var exercises = [
        Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
            Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 12),
            Set(id: UUID().uuidString, date: Date(), weight: 80, amount: 32),
            Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 9)
        ], isFolded: false),
        Exercise(id: UUID().uuidString, name: "Тяга блока", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
            Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 12),
            Set(id: UUID().uuidString, date: Date(), weight: 80, amount: 32),
            Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 9)
        ], isFolded: true),
        Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
            Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 12),
            Set(id: UUID().uuidString, date: Date(), weight: 80, amount: 32),
            Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 9)
        ], isFolded: true)
    ]
    let SetsMOCK = DataMOCK.SetsMOCK
    

    @State var isFolded = false
    
    
    @State var showChangeTimesetView = false
    @State var timerIsRinging = false
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var timerInProgress = false
    
    
    
    @State var timePeriod1 = 120
    @State var time = 120
    
    let color1 = Color("purple1")
    let color2 = Color("purple2")
    
    
    
    var body: some View {
        VStack {
            
            //main widget
            TrainingWidget(timerInProgress: $timerInProgress)
            
            //timer bar
            TimerBar(timerInProgress: $timerInProgress,
                     timerIsRinging: $timerIsRinging,
                     timePeriod1: $timePeriod1,
                     time: $time,
                     showChangeTimesetView: $showChangeTimesetView)
            
            // addExerciseBar
            HStack {
                Text("Упражнения")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color(.systemGray))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            
            
            //exercises list
            ScrollView {
                ForEach(exercises, id: \.self) { exercise in
                    VStack {
                            HStack {
                                Text("Жим лежа")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                PurpleCircles(amount: 3, isActive: $timerInProgress)
                                Image(systemName: "chevron.right")
                                    .rotationEffect(.degrees(exercise.isFolded ? 0 : 90))
                                    .fontWeight(.bold)
                                    .frame(width: 16)
                                    .padding(.leading, 12)
                                    .onTapGesture {
                                        withAnimation {
                                            withAnimation() {
                                                
                                                foldExerciseInfo(byID: exercise.id)
                                            }
                                            
                                        }
                                        
                                    }
                            }
                            .padding(.horizontal, 12)
                            
                        
                        
                    
                    if exercise.isFolded {
                        EmptyView()
                            .matchedGeometryEffect(id: "AlbumTitle" + exercise.id, in: animation)
                        
                    }
                    else { //разложено

                            
                                VStack {
                                    ForEach(exercise.sets, id: \.self) { setItem in
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(Color(.systemGray3))
                                                    .frame(width: 150, height: 40)
                                                Text(String(format: "%.1f", setItem.weight))
                                            }
                                            Spacer()
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(Color(.systemGray3))
                                                    .frame(width: 150, height: 40)
                                                
                                                Text("\(setItem.amount)")
                                            }
                                            
                                            
                                        }
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    }
                                }
                                .padding(.vertical, 10)
                                
                                .matchedGeometryEffect(id: "AlbumTitle" + exercise.id, in: animation)
                                
                                
                            
                            .padding(.horizontal, 12)
                    }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(.systemGray5))
                            .padding(.horizontal, 1)
                        
                    )
                  
                }
                
            }
            
            
        }
        .padding(.horizontal, 10)
        .onReceive(self.timer) { _ in
            if timerInProgress {
                if time > 0 {
                    withAnimation {
                        time  -= 1
                    }
                } else {
                    timerIsRinging = true
                    print("Время вышло")
                }
                
            }
        }
        
        .sheet(isPresented: $showChangeTimesetView) {
            VStack {
                Text("Изменить время")
            }
//                .presentationDetents([.height(200)])
        }
    }
    
    
    
    func foldExerciseInfo(byID id: String) {
        for index in exercises.indices {
            if exercises[index].id == id {
                exercises[index].isFolded.toggle()
                return
            }
        }
    }
}

#Preview {
    MainTrainingPage()
        .preferredColorScheme(.dark)
}
