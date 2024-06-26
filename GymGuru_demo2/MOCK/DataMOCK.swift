//
//  DataMOCK.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 15.02.2024.
//

import Foundation

class DataMOCK {
    
    static let shared = DataMOCK()
    
    //18 штук
    static let SetsMOCK = [
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 12), //0
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 8), //4
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 12), //9
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 6), //14
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 8), //20
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 8), //23
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
    ]
    
    
    let TrainingsMOCK: [Training] = [
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(0),
                 dateEnd: Date.now.addingTimeInterval(783),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[10],
                        SetsMOCK[2],
                        SetsMOCK[17]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[13],
                        SetsMOCK[2],
                    ]),
                    
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-200000),
                 dateEnd: Date.now.addingTimeInterval(-19700),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[13]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[9],
                        SetsMOCK[7],
                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-430349),
                 dateEnd: Date.now.addingTimeInterval(-430000),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[0],
                        SetsMOCK[7],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-704080),
                 dateEnd: Date.now.addingTimeInterval(-703800),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Тяга блока", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[9],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-804800),
                 dateEnd: Date.now.addingTimeInterval(-803832),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
                        //                        SetsMOCK[0],
                        //                        SetsMOCK[26],
                        //                        SetsMOCK[9],
                        //                        SetsMOCK[3],
                        //                        SetsMOCK[0],
                        //                        SetsMOCK[26],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[15],
                        SetsMOCK[8],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[1],
                        SetsMOCK[13],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-904832),
                 dateEnd: Date.now.addingTimeInterval(-903799),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[20],
                        SetsMOCK[26],
                        SetsMOCK[9],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Тяга блока", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[8],
                        SetsMOCK[4],
                        SetsMOCK[2]
                    ])
                 ]),
        
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1004900),
                 dateEnd: Date.now.addingTimeInterval(-1003281),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[23],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[26],
                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1104327),
                 dateEnd: Date.now.addingTimeInterval(-1103930),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[20],
                        SetsMOCK[3],
                        SetsMOCK[0],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-140511),
                 dateEnd: Date.now.addingTimeInterval(-703800),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[9],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Разводка", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[1],
                        SetsMOCK[25],
                        SetsMOCK[2]
                    ])
                 ]),
        
        
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1503800),
                 dateEnd: Date.now.addingTimeInterval(-1503111),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        
                        SetsMOCK[0],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-2004500),
                 dateEnd: Date.now.addingTimeInterval(-2003800),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        
                        SetsMOCK[20],
                        SetsMOCK[3],
                        SetsMOCK[0],
                        
                        
                    ]),
                    Exercise(id: UUID().uuidString, name: "Разводка", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[4],
                        SetsMOCK[10],
                        SetsMOCK[7]
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-3004500),
                 dateEnd: Date.now.addingTimeInterval(-3003800),
                 
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Разводка", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[4],
                        SetsMOCK[10],
                        SetsMOCK[7]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[15],
                        SetsMOCK[25],
                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-20045110),
                 dateEnd: Date.now.addingTimeInterval(-703800),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        
                        SetsMOCK[0]
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1468800),
                 dateEnd: Date.now.addingTimeInterval(-703800),
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        
                        SetsMOCK[0]
                    ])
                 ]),
    ]
    
}
