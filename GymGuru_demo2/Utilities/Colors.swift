//
//  Colors.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 13.03.2024.
//

import Foundation
import SwiftUI

class Colors {
    
    static let shared = Colors()
    
    let linearGradientBlue = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.6), Color.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    let linearGradientOrange = LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.6), .orange.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    let linearGradientOrange2 = LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.3), .orange.opacity(0)]), startPoint: .top, endPoint: .bottom)
}


