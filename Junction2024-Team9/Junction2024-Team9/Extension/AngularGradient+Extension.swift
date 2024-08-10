//
//  AngularGradient+Extension.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

extension AngularGradient {
    static var customAngularGradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.05)]), center: .center, startAngle: .degrees(90), endAngle: .degrees(-250))
    }
}
