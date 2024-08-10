//
//  StoreView.swift
//  Junction2024-Team9
//
//  Created by Damin on 8/11/24.
//

import SwiftUI

struct StoreView: View {
    var myCoin: Int = 1000
    var body: some View {
        VStack {
            HStack {
                Text("Store")
                    .fontWeight(.semibold)
                    .font(.system(size: 38))
                    .foregroundStyle(.white)
                
                Spacer()
                
                MyCoinView(coin: myCoin)
            }
            VStack {
                HStack {
                    Text("Certificate")
                    Spacer()
                }
                .padding(.horizontal)
                
                Image("gift10000")
                    .background {
                        Image("phohangBear")
                            .offset(x: 120, y: -90)
                    }
                HStack {
                    Text("Phohang Gift Certificate ₩ 10,000")
                    Spacer()
                    Image("coin 1")
                        .padding(.trailing, -10)
                    Text("1,000")
                        .font(.paperlogy(size: 18, weight: .bold))
                }
                .padding(.top, 10)
                
                Image("gift5000")
                    .padding(.top, 40)
                HStack {
                    Text("Phohang Gift Certificate ₩ 5,000")
                    Spacer()
                    Image("coin 1")
                        .padding(.trailing, -10)
                    Text("500")
                        .font(.paperlogy(size: 18, weight: .bold))
                }
                .padding(.top, 10)
                
            }
            .padding(.top, 50)
            
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    StoreView()
}
