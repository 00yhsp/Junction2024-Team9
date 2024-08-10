//
//  HomeVIew.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    @State var name: String = "~~"
    @State var coinAmount: Int = 0

    var body: some View {
        ZStack {
            RadarView()
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    CoinView()
                }.padding(.horizontal, 20)
                    .padding(.top, 25)
                Spacer()
            }

        }
        .background(.black)
    }
}

private struct CoinView: View {
    let coinAmount: Int = 0

    var body: some View {
        HStack {
            Image(.coin1)
                .padding(.leading, 9)
                .padding(.trailing, 15)
            Text("\(coinAmount)")
                .font(.paperlogy(size: 24, weight: .regular))
                .foregroundStyle(.white)
                .padding(.trailing, 26)
        }
        .background(Color(red: 0.03, green: 0.6, blue: 0.84).opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(uiColor: UIColor(red: 0.03, green: 0.6, blue: 0.84, alpha: 0.2)), lineWidth: 1)
        )
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
                .strokeBorder(Color.brand500, lineWidth: 1)
                .frame(width: 118)
            Circle()
                .strokeBorder(Color.brand500.opacity(0.5), lineWidth: 1)
                .frame(width: 313)
            Circle()
                .strokeBorder(Color.brand500.opacity(0.3), lineWidth: 1)
                .frame(width: 488)
            Circle()
                .strokeBorder(Color.brand500.opacity(0.2), lineWidth: 1)
                .frame(width: 653)
            QuadCircle(start: .degrees(100), end: .degrees(220))
                .fill(AngularGradient.customAngularGradient)
                .frame(width: 653)
                .rotationEffect(.degrees(startAnimation ? 360 : 0))
        }.onAppear(perform: performAnimation)
            .containerRelativeFrame(.horizontal)
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
