//
//  Program.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 19.03.2024.
//

import Foundation
import SwiftUI

struct Program: Identifiable, Hashable {
    let id: String
    
    var name: String
    
    //пока поиск у нас идет по имени, а не id
    //и тут будет иметь значение порядок элементов
    var exercises: [String]
    
    var color: Color
}


