//
//  InformationView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .background(.red)
                .aspectRatio(282 / 313, contentMode: .fit)
                .padding(.horizontal, 25)
            TitleAndContentView(title: "카테고리", content: "위치")
            TitleAndContentView(title: "위치", content: "위치")
            TitleAndContentView(title: "촬영 시간", content: "위치")
        }.padding(.horizontal, 30)
    }
}

private struct TitleAndContentView: View {
    let title: String
    let content: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
        }
        HStack {
            Text(content)
            Spacer()
        }.background(.gray)
    }
}

private struct ButtonGroupView: View {
    @EnvironmentObject private var router: AppRouter
    var body: some View {
        HStack(spacing: 20) {
            Button {
                router.pop()
            } label: {
                Text("다시")
            }.frame(maxWidth: .infinity)
            Button {
                router.goHome()
            } label: {
                Text("확인")
            }.frame(maxWidth: .infinity)
        }.frame(height: 60)

    }
}

#Preview {
    InformationView()
}
