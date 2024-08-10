//
//  HomeVIew.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    @State var name: String = "~~"
    @State var pointAmount: Int = 0

    var body: some View {
        ZStack {
            RadarView()
        }
    }
}

private struct RadarView: View {
    @State var startAnimation = false
    @State var fadeAnimation1 = false
    @State var fadeAnimation2 = false
    @State var fadeAnimation3 = false

    var body: some View {
        Group {
            Circle()
                .strokeBorder(.gray, lineWidth: 0.3)
                .frame(width: 118)
            Circle()
                .strokeBorder(.gray, lineWidth: 0.3)
                .frame(width: 313)
            Circle()
                .strokeBorder(.gray, lineWidth: 0.3)
                .frame(width: 488)
            Circle()
                .strokeBorder(.gray, lineWidth: 0.3)
                .frame(width: 653)
            QuadCircle(start: .degrees(100), end: .degrees(220))
                .fill(AngularGradient.customAngularGradient)
                .frame(width: 653)
                .rotationEffect(.degrees(startAnimation ? 360 : 0))
        }.onAppear(perform: performAnimation)
    }

    private struct QuadCircle: Shape {
        var start: Angle
        var end: Angle

        func path(in rect: CGRect) -> Path {
            var path = Path()
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: false)
            return path
        }
    }

    private func performAnimation() {
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            startAnimation = true
        }

        withAnimation(.linear(duration: 0.7)
            .delay((1.5/360) * (90 - 105))
            .repeatForever(autoreverses: true)) {
            fadeAnimation1 = true
        }

        withAnimation(.easeInOut(duration: 0.7)
            .delay((1.5/360) * (90 - 80))
            .repeatForever(autoreverses: true)) {
            fadeAnimation2 = true
        }

        withAnimation(.linear(duration: 0.5)
            .delay((1.5/360) * (90 - 25))
            .repeatForever(autoreverses: true)) {
            fadeAnimation3 = true
        }
    }
}

#Preview {
    HomeView()
}
