//
//  CoinHistoryView.swift
//  Junction2024-Team9
//
//  Created by Damin on 8/11/24.
//

import SwiftUI

struct CoinModel: Hashable {
    var reportName: String
    var coin: Int
}

struct CoinHistoryView: View {
    var coinModelList: [CoinModel] = [
        CoinModel(reportName: "Crack", coin: 3),
        CoinModel(reportName: "Pothole", coin: 3),
        CoinModel(reportName: "Pohang Gift Certificate ₩ 10,000", coin: -10000),
        CoinModel(reportName: "Pohang Gift Certificate ₩ 10,000", coin: -10000)
    ]
    var myCoin: Int = 1100
    var body: some View {
        VStack {
            MyCoinView(coin: myCoin)
            
            List(coinModelList, id: \.self) { item in
                NavigationLink {
                    StoreView(myCoin: myCoin)
                } label: {
                    HStack {
                        Text(item.reportName)
                        Spacer()
                        Text("\(formatNumber(item.coin))")
                    }
                }

                
            }
        }
    }
    
    func formatNumber(_ value: Int) -> String {
        if value > 0 {
            return "+\(value)" // 양수일 경우 + 기호를 붙임
        } else {
            return "\(value)"  // 음수이거나 0일 경우 그대로 반환
        }
    }
}

struct MyCoinView: View {
    var coinString: String
    
    init(coin: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current  // 현재 로케일을 사용하여 형식 지정

        if let formattedNumber = numberFormatter.string(from: NSNumber(value: coin)) {
            self.coinString =  formattedNumber
        } else {
            self.coinString = "\(coin)"  // 변환 실패 시 원래 숫자를 반환
        }
    }
    var body: some View {
        ZStack {
            //피그마 코드
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 109, height: 44)
            .background(Color(red: 0.03, green: 0.6, blue: 0.84).opacity(0.2))
            .cornerRadius(100)
            .overlay(
            RoundedRectangle(cornerRadius: 100)
            .inset(by: 0.5)
            .stroke(Color(red: 0.03, green: 0.6, blue: 0.84).opacity(0.1), lineWidth: 1)
            )
            HStack {
                Image("coin 1")
                Text(coinString)
                    .font(.paperlogy(size: 18, weight: .medium))
                    .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    CoinHistoryView()
}
