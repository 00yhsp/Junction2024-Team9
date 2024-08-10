//
//  HomeVIew.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI
import Lottie

@Observable
final class HomeTriggerWrapper {
    var trigger = false
}

struct HomeView: View {
    @State var adImages = [Image(.cinema), Image(.icecream), Image(.coffee)]
    @State var name: String = "~~"
    @State var coinAmount: Int = 0
    @State var isClicked = false
    @State var randomIdx: Int = 0
    @State var othersDisabled: Bool = false
    @State var roadDisabled: Bool = true
    @State var trigger = HomeTriggerWrapper()


    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            RadarView()
            VStack(spacing: 0) {
                HeaderView(coinAmount: coinAmount)
                Spacer()
            }
            Image(.mainbear)
            VStack {
                adImages[randomIdx]
                Text("Advertisement")
                    .font(.paperlogy(size: 12, weight: .regular))
            }.offset(x: -120, y: -110)
            VStack {
                Image(.store)
                Text("Store")
                    .font(.paperlogy(size: 12, weight: .regular))
            }.offset(x: -90, y: 260)
            VStack {
                Image(.store)
                Text("Declare\nOthers")
                    .font(.paperlogy(size: 12, weight: .regular))
            }.offset(x: 70, y: -220)
                .onTapGesture {
                    if !othersDisabled {
                        othersDisabled = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            othersDisabled = false
                        }
                    }
                }
            VStack {
                Image(.store)
                Text("Declare\nRoad")
                    .font(.paperlogy(size: 12, weight: .regular))
            }.offset(x: 100, y: 200)
                .onTapGesture {
                    if !roadDisabled {
                        roadDisabled = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            roadDisabled = false
                        }
                    }
                    else {
                        trigger.trigger = true
                    }
                }
            if !isClicked {
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 280, height: 280)
                            .foregroundStyle(.black)
                        Circle()
                            .frame(width: 280, height: 280)
                            .opacity(0.2)
                            .blur(radius: 5)
                        LottieView(animation: .named("click animation"))
                            .looping()
                            .offset(y: -20)
                        Text("Click Circles")
                            .font(.paperlogy(size: 20, weight: .regular))
                            .offset(y: 90)
                    }.onTapGesture {
                        isClicked = true
                    }
                    Spacer()
                }.background(.black.opacity(0.8))
            }
            if othersDisabled {
                VStack {
                    Spacer()
                    Text("⚠️ detection exists")
                        .font(.paperlogy(size: 16, weight: .regular))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 43)
                        .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .padding(.bottom, 80)
                }
            }
        }
        .background(.black)
        .onReceive(timer) { _ in
            randomIdx = Int.random(in: 0...2)
        }
        .navigationDestination(isPresented: $trigger.trigger) {
            CaptureView()
        }
        .environment(trigger)
    }
}

private struct HeaderView: View {
    let coinAmount: Int
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Hello")
                        .font(.paperlogy(size: 24, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack {
                    Text("POSCO")
                        .font(.paperlogy(size: 28, weight: .bold))
                        .foregroundStyle(Color.brand400)
                    Spacer()
                }
            }
            Spacer()
            CoinView(coinAmount: coinAmount)
        }.padding(.horizontal, 20)
            .padding(.top, 25)

    }
}

private struct CoinView: View {
    let coinAmount: Int

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
